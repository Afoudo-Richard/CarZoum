import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'vehicle_detail_event.dart';
part 'vehicle_detail_state.dart';

const _duration = Duration(milliseconds: 300);

class VehicleDetailBloc extends Bloc<VehicleDetailEvent, VehicleDetailState> {
  VehicleDetailBloc({
    required this.vehicle,
  }) : super(VehicleDetailState()) {
    on<VehiclesDetailSimilarVehiclesFetched>(
      _onVehiclesDetailSimilarVehiclesFetched,
      transformer: debounce(
        _duration,
      ),
    );
  }

  final Vehicle vehicle;

  void _onVehiclesDetailSimilarVehiclesFetched(
    VehiclesDetailSimilarVehiclesFetched event,
    Emitter<VehicleDetailState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }
    try {
      if (state.listSimilarVehiclesStatus ==
              ListSimilarVehiclesStatus.initial ||
          event.refresh) {
        if (event.refresh) {
          emit(state.copyWith(
            listSimilarVehiclesStatus: ListSimilarVehiclesStatus.refresh,
          ));
        }
        final vehicles = await _fetchVehicles();

        return emit(state.copyWith(
          listSimilarVehiclesStatus: ListSimilarVehiclesStatus.success,
          vehicles: _filterVehicles(vehicles),
          hasReachedMax: vehicles.length < AppConfigs.fetchLimit ? true : false,
        ));
      }

      final vehicles = await _fetchVehicles(startIndex: state.vehicles.length);

      emit(
        vehicles.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                listSimilarVehiclesStatus: ListSimilarVehiclesStatus.success,
                vehicles: List.of(state.vehicles)
                  ..addAll(
                    _filterVehicles(vehicles),
                  ),
                hasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(
        state.copyWith(
            listSimilarVehiclesStatus: ListSimilarVehiclesStatus.failure),
      );
    }
  }

  List<Vehicle> _filterVehicles(List<Vehicle> vehicles) {
    return vehicles.where((item) => vehicle.objectId != item.objectId).toList();
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
      ..whereEqualTo('brand', vehicle.brand)
      ..whereEqualTo("status", AdvertStatus.active.name)
      ..setLimit(limit);

    return query.find();
  }
}
