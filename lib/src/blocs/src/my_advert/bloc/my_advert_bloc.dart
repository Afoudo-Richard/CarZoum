import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'my_advert_event.dart';
part 'my_advert_state.dart';

class MyAdvertBloc extends Bloc<MyAdvertEvent, MyAdvertState> {
  MyAdvertBloc({
    required this.userBloc,
  }) : super(MyAdvertState()) {
    on<MyAdvertStatusChanged>(_onMyAdvertCategoryChanged);
    on<MyAdvertsCategoryFetched>(_onMyAdvertsCategoryFetched);
    on<MyAdvertsActiveCountFetched>(_onMyAdvertsActiveCountFetched);
    on<MyAdvertsDeclinedCountFetched>(_onMyAdvertsDeclinedCountFetched);
    on<MyAdvertsReviewingCountFetched>(_onMyAdvertsReviewingCountFetched);
    on<MyAdvertsClosedCountFetched>(_onMyAdvertsClosedCountFetched);
    on<MyAdvertsAllCountFetched>(_onMyAdvertsAllCountFetched);
    on<MyAdvertsChangeStatus>(_onMyAdvertsChangeStatus);
  }

  final UserBloc userBloc;

  _onMyAdvertCategoryChanged(
    MyAdvertStatusChanged event,
    Emitter<MyAdvertState> emit,
  ) {
    emit(
      state.copyWith(
        advertStatus: event.advertStatus,
      ),
    );
  }

  _onMyAdvertsChangeStatus(
    MyAdvertsChangeStatus event,
    Emitter<MyAdvertState> emit,
  ) async {
    emit(
      state.copyWith(
        currentVehicle: event.vehicle,
      ),
    );
    try {
      if (event.advertsVerificationStatus == AdvertsVerificationStatus.accept) {
        emit(
          state.copyWith(
            advertAcceptStatus: AdvertAcceptStatus.loading,
          ),
        );
        await _updateVehicleStatus(
          event.vehicle,
          event.advertsVerificationStatus,
        );

        emit(
          state.copyWith(
            advertAcceptStatus: AdvertAcceptStatus.success,
          ),
        );

        try {
          User user = userBloc.state.user!;
          await _sendUserNotification(
              user.objectId!, "Your advert has been accepted");
        } catch (e) {
          debugPrint("Errrrooooooooooorr @@@@@@@@@@@@@@##########");
        }
      } else {
        emit(
          state.copyWith(
            advertDeclineStatus: AdvertDeclineStatus.loading,
          ),
        );
        await _updateVehicleStatus(
          event.vehicle,
          event.advertsVerificationStatus,
        );
        emit(
          state.copyWith(
            advertDeclineStatus: AdvertDeclineStatus.success,
          ),
        );
      }

      add(const MyAdvertsCategoryFetched(refresh: true));
    } catch (e) {
      if (event.advertsVerificationStatus == AdvertsVerificationStatus.accept) {
        emit(
          state.copyWith(
            advertAcceptStatus: AdvertAcceptStatus.failure,
          ),
        );
      } else {
        emit(
          state.copyWith(
            advertDeclineStatus: AdvertDeclineStatus.failure,
          ),
        );
      }
    } finally {
      emit(
        state.copyWith(
          currentVehicle: null,
        ),
      );
    }
  }

  Future _sendUserNotification(String id, String message) async {
    final ParseCloudFunction function =
        ParseCloudFunction('sendPushToUserAboutAdStatus');

    final Map<String, dynamic> params = <String, dynamic>{
      'id': id,
      'message': message,
    };
    final ParseResponse parseResponse =
        await function.executeObjectFunction<ParseObject>(parameters: params);

    // ended here
    if (parseResponse.success && parseResponse.result != null) {
      print(parseResponse.result);
    }
  }

  Future _updateVehicleStatus(Vehicle vehicle,
      AdvertsVerificationStatus advertsVerificationStatus) async {
    String status = '';

    switch (advertsVerificationStatus) {
      case AdvertsVerificationStatus.accept:
        status = AdvertStatus.active.name;
        break;
      case AdvertsVerificationStatus.decline:
        status = AdvertStatus.declined.name;
        break;
      default:
    }
    var vehi = Vehicle()
      ..objectId = vehicle.objectId
      ..status = status;

    var response = await vehi.save();

    if (response.success) {
      // return store;
    } else {
      throw ErrorUpdatingAdvertStatus(message: response.error?.message);
    }
  }

  _onMyAdvertsCategoryFetched(
    MyAdvertsCategoryFetched event,
    Emitter<MyAdvertState> emit,
  ) async {
    add(MyAdvertsAllCountFetched());

    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }
    try {
      if (state.myAdvertFetchStatus == MyAdvertFetchStatus.initial ||
          event.refresh) {
        if (event.refresh) {
          emit(state.copyWith(
            myAdvertFetchStatus: MyAdvertFetchStatus.refresh,
          ));
        }
        final vehicles = await _fetchVehicles();

        return emit(state.copyWith(
          myAdvertFetchStatus: MyAdvertFetchStatus.success,
          vehicles: vehicles,
          hasReachedMax: vehicles.length < AppConfigs.fetchLimit ? true : false,
        ));
      }

      final vehicles = await _fetchVehicles(startIndex: state.vehicles.length);

      emit(
        vehicles.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                myAdvertFetchStatus: MyAdvertFetchStatus.success,
                vehicles: List.of(state.vehicles)..addAll(vehicles),
                hasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(state.copyWith(myAdvertFetchStatus: MyAdvertFetchStatus.failure));
    }
  }

  _onMyAdvertsAllCountFetched(
    MyAdvertsAllCountFetched event,
    Emitter<MyAdvertState> emit,
  ) async {
    add(MyAdvertsActiveCountFetched());
    add(MyAdvertsDeclinedCountFetched());
    add(MyAdvertsReviewingCountFetched());
    add(MyAdvertsClosedCountFetched());
  }

  _onMyAdvertsActiveCountFetched(
    MyAdvertsActiveCountFetched event,
    Emitter<MyAdvertState> emit,
  ) async {
    try {
      final totalAds = await _fetchTotalActiveVehicleCount();
      emit(
        state.copyWith(
          totalActiveVechicles: totalAds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          totalActiveVechicles: 0,
        ),
      );
    }
  }

  _onMyAdvertsDeclinedCountFetched(
    MyAdvertsDeclinedCountFetched event,
    Emitter<MyAdvertState> emit,
  ) async {
    try {
      final totalAds = await _fetchTotalDeclinedVehicleCount();
      emit(
        state.copyWith(
          totalDeclinedVehicles: totalAds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          totalDeclinedVehicles: 0,
        ),
      );
    }
  }

  _onMyAdvertsReviewingCountFetched(
    MyAdvertsReviewingCountFetched event,
    Emitter<MyAdvertState> emit,
  ) async {
    try {
      final totalAds = await _fetchTotalReviewingVehicleCount();
      emit(
        state.copyWith(
          totalReviewingVehicles: totalAds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          totalReviewingVehicles: 0,
        ),
      );
    }
  }

  _onMyAdvertsClosedCountFetched(
    MyAdvertsClosedCountFetched event,
    Emitter<MyAdvertState> emit,
  ) async {
    try {
      final totalAds = await _fetchTotalClosedVehicleCount();
      emit(
        state.copyWith(
          totalClosedVehicles: totalAds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          totalClosedVehicles: 0,
        ),
      );
    }
  }

  Future<List<Vehicle>> _fetchVehicles({
    int startIndex = 0,
    int limit = AppConfigs.fetchLimit,
  }) async {
    QueryBuilder<Vehicle> query = QueryBuilder(Vehicle())
      ..setAmountToSkip(startIndex)
      ..orderByDescending('createdAt')
      ..includeObject([
        'brand',
        'model',
        'condition_type',
        'fuel_type',
        'transmission_type',
        'user',
        'store',
      ])
      // ..whereEqualTo('user', userBloc.state.user?.objectId)
      ..whereEqualTo('status', state.advertStatus.name)
      ..setLimit(limit);

    if (userBloc.state.user!.isAdmin == false) {
      query.whereEqualTo('store', userBloc.state.user?.store);
    }

    return query.find();
  }

  Future<int> _fetchTotalActiveVehicleCount() async {
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle())
      ..whereEqualTo('status', AdvertStatus.active.name);
    if (userBloc.state.user!.isAdmin == false) {
      query.whereEqualTo('store', userBloc.state.user?.store);
    }
    var apiResponse = await query.count();
    if (apiResponse.success && apiResponse.result != null) {
      return apiResponse.count;
    }
    throw ErrorFetchingAdvertCategoryCount(
      message: "Error fetching active advert",
    );
  }

  Future<int> _fetchTotalDeclinedVehicleCount() async {
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle())
      ..whereEqualTo('status', AdvertStatus.declined.name);
    if (userBloc.state.user!.isAdmin == false) {
      query.whereEqualTo('store', userBloc.state.user?.store);
    }
    var apiResponse = await query.count();
    if (apiResponse.success && apiResponse.result != null) {
      return apiResponse.count;
    }
    throw ErrorFetchingAdvertCategoryCount(
      message: "Error fetching deleted advert",
    );
  }

  Future<int> _fetchTotalReviewingVehicleCount() async {
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle())
      ..whereEqualTo('status', AdvertStatus.reviewing.name);
    if (userBloc.state.user!.isAdmin == false) {
      query.whereEqualTo('store', userBloc.state.user?.store);
    }
    var apiResponse = await query.count();
    if (apiResponse.success && apiResponse.result != null) {
      return apiResponse.count;
    }
    throw ErrorFetchingAdvertCategoryCount(
      message: "Error fetching reviewing advert",
    );
  }

  Future<int> _fetchTotalClosedVehicleCount() async {
    QueryBuilder<Vehicle> query = QueryBuilder<Vehicle>(Vehicle())
      ..whereEqualTo('status', AdvertStatus.closed.name);
    if (userBloc.state.user!.isAdmin == false) {
      query.whereEqualTo('store', userBloc.state.user?.store);
    }
    var apiResponse = await query.count();
    if (apiResponse.success && apiResponse.result != null) {
      return apiResponse.count;
    }
    throw ErrorFetchingAdvertCategoryCount(
      message: "Error fetching closed advert",
    );
  }
}
