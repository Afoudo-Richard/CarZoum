import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_filter_event.dart';
part 'search_filter_state.dart';

const _duration = Duration(milliseconds: 300);

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc() : super(SearchFilterState(
            // initialEndYearOfManufacture: DateTime.now().year,
            // endYearOfManufacture: DateTime.now().year,
            )) {
    on<SearchFilterVehicleBrandChanged>(_onSearchFilterVehicleBrandChanged);
    on<SearchFilterVehicleModelChanged>(_onSearchFilterVehicleModelChanged);
    on<SearchFilterVehicleYearOfManufactureChanged>(
        _onSearchFilterVehicleYearOfManufactureChanged);
    on<SearchFilterVehicleFuelTypeChanged>(
        _onSearchFilterVehicleFuelTypeChanged);
    on<SearchFilterVehicleConditionTypeChanged>(
        _onSearchFilterVehicleConditionTypeChanged);
    on<SearchFilterVehicleTransmissionTypeChanged>(
        _onSearchFilterVehicleTransmissionTypeChanged);
    on<SearchFilterVehiclePriceRangeChanged>(
        _onSearchFilterVehiclePriceRangeChanged);
    on<SearchFilterVehicleMileageRangeChanged>(
        _onSearchFilterVehicleMileageRangeChanged);
    on<SearchFilterVehicleIsRegisteredChanged>(
        _onSearchFilterVehicleIsRegisteredChanged);
    on<SearchFilterVehicleIsNegotiableChanged>(
        _onSearchFilterVehicleIsNegotiableChanged);
    // on<SearchFilterVehiclesFetched>(_onSearchFilterVehiclesFetched);
    on<SearchFilterResetted>(_onSearchFilterResetted);
    on<SearchFilterSubmitted>(
      _onSearchFilterSubmitted,
      transformer: debounce(
        _duration,
      ),
    );
  }

  static const int _fetchLimit = 10;

  void _onSearchFilterVehicleBrandChanged(
    SearchFilterVehicleBrandChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        brand: event.brand,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterVehicleModelChanged(
    SearchFilterVehicleModelChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        brand: state.brand,
        model: event.model,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterVehicleYearOfManufactureChanged(
    SearchFilterVehicleYearOfManufactureChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        startYearOfManufacture: event.startYear,
        endYearOfManufacture: event.endYear,
        brand: state.brand,
        model: state.model,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterVehicleFuelTypeChanged(
    SearchFilterVehicleFuelTypeChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        fuelType: event.fuelType,
        brand: state.brand,
        model: state.model,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterVehicleConditionTypeChanged(
    SearchFilterVehicleConditionTypeChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        conditionType: event.conditionType,
        brand: state.brand,
        model: state.model,
        fuelType: state.fuelType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterVehicleTransmissionTypeChanged(
    SearchFilterVehicleTransmissionTypeChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        transmissionType: event.transmissionType,
        brand: state.brand,
        model: state.model,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
      ),
    );
  }

  void _onSearchFilterVehiclePriceRangeChanged(
    SearchFilterVehiclePriceRangeChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        startPrice: event.startPrice,
        endPrice: event.endPrice,
        brand: state.brand,
        model: state.model,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterVehicleMileageRangeChanged(
    SearchFilterVehicleMileageRangeChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        startMileage: event.startMileage,
        endMileage: event.endMileage,
        brand: state.brand,
        model: state.model,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterVehicleIsRegisteredChanged(
    SearchFilterVehicleIsRegisteredChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        isRegistered: event.isRegistered,
        brand: state.brand,
        model: state.model,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterVehicleIsNegotiableChanged(
    SearchFilterVehicleIsNegotiableChanged event,
    Emitter<SearchFilterState> emit,
  ) {
    emit(
      state.copyWith(
        isNegotiable: event.isNegotiable,
        brand: state.brand,
        model: state.model,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ),
    );
  }

  void _onSearchFilterResetted(
    SearchFilterResetted event,
    Emitter<SearchFilterState> emit,
  ) async {
    emit(
      SearchFilterState(),
    );
  }

  void _onSearchFilterSubmitted(
    SearchFilterSubmitted event,
    Emitter<SearchFilterState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }
    try {
      if (state.searchFilterStatus == SearchFilterStatus.initial ||
          event.refresh) {
        if (event.refresh || event.isFromButton) {
          emit(state.copyWith(
            searchFilterStatus: SearchFilterStatus.refresh,
            brand: state.brand,
            model: state.model,
            fuelType: state.fuelType,
            conditionType: state.conditionType,
            transmissionType: state.transmissionType,
          ));
        }
        final vehicles = await _searchVehicles();

        return emit(state.copyWith(
          searchFilterStatus: SearchFilterStatus.success,
          vehicles: vehicles,
          hasReachedMax: vehicles.length < _fetchLimit ? true : false,
          brand: state.brand,
          model: state.model,
          fuelType: state.fuelType,
          conditionType: state.conditionType,
          transmissionType: state.transmissionType,
        ));
      }

      if (event.isFromButton) {
        emit(state.copyWith(
          searchFilterStatus: SearchFilterStatus.refresh,
          brand: state.brand,
          model: state.model,
          fuelType: state.fuelType,
          conditionType: state.conditionType,
          transmissionType: state.transmissionType,
        ));
      }

      final vehicles = await _searchVehicles(
        startIndex: event.isFromButton ? 0 : state.vehicles.length,
      );

      emit(
        vehicles.isEmpty
            ? state.copyWith(
                hasReachedMax: true,
                brand: state.brand,
                model: state.model,
                fuelType: state.fuelType,
                conditionType: state.conditionType,
                transmissionType: state.transmissionType,
              )
            : state.copyWith(
                searchFilterStatus: SearchFilterStatus.success,
                vehicles: List.of(state.vehicles)..addAll(vehicles),
                hasReachedMax: false,
                brand: state.brand,
                model: state.model,
                fuelType: state.fuelType,
                conditionType: state.conditionType,
                transmissionType: state.transmissionType,
              ),
      );
    } catch (_) {
      emit(state.copyWith(
        searchFilterStatus: SearchFilterStatus.failure,
        brand: state.brand,
        model: state.model,
        fuelType: state.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
      ));
    }
  }

  Future<List<Vehicle>> _searchVehicles(
      {int startIndex = 0, int limit = _fetchLimit}) async {
    QueryBuilder<Vehicle> query = QueryBuilder(Vehicle())
      ..setAmountToSkip(startIndex)
      ..orderByDescending('createdAt')
      ..includeObject([
        'brand',
        'model',
        'condition_type',
        'fuel_type',
        'transmission_type',
      ])
      ..whereEqualTo("status", AdvertStatus.active.name)
      ..setLimit(limit);
    if (state.brand != null) query.whereEqualTo('brand', state.brand);
    if (state.model != null) query.whereEqualTo('model', state.model);
    if (state.fuelType != null) query.whereEqualTo('fuel_type', state.fuelType);
    if (state.conditionType != null)
      query.whereEqualTo('condition_type', state.conditionType);
    if (state.transmissionType != null)
      query.whereEqualTo('transmission_type', state.transmissionType);
    if (state.isRegistered != null)
      query.whereEqualTo('is_registered', state.isRegistered);
    if (state.isNegotiable != null)
      query.whereEqualTo('is_negotiable', state.isNegotiable);
    // query.whereGreaterThanOrEqualsTo('price', state.startPrice);
    // query.whereLessThanOrEqualTo('price', state.endPrice);

    query.whereGreaterThanOrEqualsTo(
        'year_of_manufacture', state.startYearOfManufacture);
    query.whereLessThanOrEqualTo(
        'year_of_manufacture', state.endYearOfManufacture);
    if (state.startMileage != state.initialStartMileage ||
        state.endMileage != state.initialEndMileage) {
      query.whereGreaterThanOrEqualsTo('mileage', state.startMileage);
      query.whereLessThanOrEqualTo('mileage', state.endMileage);
    }

    return query.find();
  }
}
