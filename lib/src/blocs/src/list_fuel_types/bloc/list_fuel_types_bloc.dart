import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'list_fuel_types_event.dart';
part 'list_fuel_types_state.dart';

class ListFuelTypesBloc
    extends HydratedBloc<ListFuelTypesEvent, ListFuelTypesState> {
  ListFuelTypesBloc() : super(const ListFuelTypesState()) {
    on<FuelTypesFetched>(_onFuelTypesFetched);
  }

  void _onFuelTypesFetched(
    FuelTypesFetched event,
    Emitter<ListFuelTypesState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }

    try {
      final fuelTypes = await _fetchFuelTypes();

      return emit(
        state.copyWith(
          listFuelTypesStatus: ListFuelTypesStatus.success,
          fuelTypes: fuelTypes,
          hasReachedMax: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(listFuelTypesStatus: ListFuelTypesStatus.failure));
    }
  }

  Future<List<FuelType>> _fetchFuelTypes() async {
    QueryBuilder<FuelType> query = QueryBuilder(FuelType());
    return query.find();
  }

  @override
  ListFuelTypesState? fromJson(Map<String, dynamic> json) {
    return ListFuelTypesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ListFuelTypesState state) {
    return state.toMap();
  }
}
