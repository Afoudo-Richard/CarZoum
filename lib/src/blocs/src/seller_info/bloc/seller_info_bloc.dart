import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'seller_info_event.dart';
part 'seller_info_state.dart';

const _duration = Duration(milliseconds: 300);

class SellerInfoBloc extends Bloc<SellerInfoEvent, SellerInfoState> {
  SellerInfoBloc({
    required this.user,
  }) : super(SellerInfoState()) {
    on<SellerInfoVehiclesFetched>(_onSellerInfoVehiclesFetched,
        transformer: debounce(
          _duration,
        ));
  }
  final User user;
  static const int _fetchLimit = 10;

  void _onSellerInfoVehiclesFetched(
    SellerInfoVehiclesFetched event,
    Emitter<SellerInfoState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }
    try {
      if (state.sellerInfoListVehiclesStatus ==
              SellerInfoListVehiclesStatus.initial ||
          event.refresh) {
        if (event.refresh) {
          emit(state.copyWith(
            sellerInfoListVehiclesStatus: SellerInfoListVehiclesStatus.refresh,
          ));
        }
        final vehicles = await _fetchVehicles();

        return emit(state.copyWith(
          sellerInfoListVehiclesStatus: SellerInfoListVehiclesStatus.success,
          vehicles: vehicles,
          hasReachedMax: vehicles.length < _fetchLimit ? true : false,
        ));
      }

      final vehicles = await _fetchVehicles(startIndex: state.vehicles.length);

      emit(
        vehicles.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                sellerInfoListVehiclesStatus:
                    SellerInfoListVehiclesStatus.success,
                vehicles: List.of(state.vehicles)..addAll(vehicles),
                hasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(state.copyWith(
          sellerInfoListVehiclesStatus: SellerInfoListVehiclesStatus.failure));
    }
  }

  Future<List<Vehicle>> _fetchVehicles(
      {int startIndex = 0, int limit = _fetchLimit}) async {
    QueryBuilder<Vehicle> query = QueryBuilder(Vehicle())
      ..setAmountToSkip(startIndex)
      ..orderByDescending('createdAt')
      ..whereEqualTo('user', user)
      ..includeObject([
        'brand',
        'model',
        'condition_type',
        'fuel_type',
        'transmission_type',
        'user',
        'store',
      ])
      ..setLimit(limit);

    return query.find();
  }
}
