import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:carzoum/carzoum.dart';
import 'package:stream_transform/stream_transform.dart';

part 'list_vehicles_event.dart';
part 'list_vehicles_state.dart';

const _duration = Duration(milliseconds: 300);

class ListVehiclesBloc extends Bloc<ListVehiclesEvent, ListVehiclesState> {
  ListVehiclesBloc() : super(ListVehiclesState()) {
    on<VehiclesFetched>(_onVehiclesFetched,
        transformer: debounce(
          _duration,
        ));
    on<VehicleViewAdded>(_onVehicleViewAdded);
  }

  void _onVehiclesFetched(
    VehiclesFetched event,
    Emitter<ListVehiclesState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }
    try {
      if (state.listVehiclesStatus == ListVehiclesStatus.initial ||
          event.refresh) {
        if (event.refresh) {
          emit(state.copyWith(
            listVehiclesStatus: ListVehiclesStatus.refresh,
          ));
        }
        final vehicles = await _fetchVehicles();

        return emit(state.copyWith(
          listVehiclesStatus: ListVehiclesStatus.success,
          vehicles: vehicles,
          hasReachedMax: vehicles.length < AppConfigs.fetchLimit ? true : false,
        ));
      }

      final vehicles = await _fetchVehicles(startIndex: state.vehicles.length);

      emit(
        vehicles.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                listVehiclesStatus: ListVehiclesStatus.success,
                vehicles: List.of(state.vehicles)..addAll(vehicles),
                hasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(
        state.copyWith(listVehiclesStatus: ListVehiclesStatus.failure),
      );
    }
  }

  void _onVehicleViewAdded(
    VehicleViewAdded event,
    Emitter<ListVehiclesState> emit,
  ) async {
    try {
      await _incrementVehicleView(event.vehicle);
    } catch (e) {
      print(e.toString());
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
      ..whereEqualTo("status", AdvertStatus.active.name)
      ..setLimit(limit);

    return query.find();
  }

  Future _incrementVehicleView(Vehicle vehicle) async {
    vehicle.setIncrement("views", 1);
    var response = await vehicle.save();
  }
}
