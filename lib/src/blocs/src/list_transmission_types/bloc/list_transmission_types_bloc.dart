import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carzoum/src/data/src/models/src/transmission_type.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'list_transmission_types_event.dart';
part 'list_transmission_types_state.dart';

class ListTransmissionTypesBloc extends HydratedBloc<ListTransmissionTypesEvent,
    ListTransmissionTypesState> {
  ListTransmissionTypesBloc() : super(const ListTransmissionTypesState()) {
    on<TransmissionTypesFetched>(_onTransmissionTypesFetched);
  }

  void _onTransmissionTypesFetched(
    TransmissionTypesFetched event,
    Emitter<ListTransmissionTypesState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }

    try {
      final transmissionTypes = await _fetchFuelTypes();

      return emit(
        state.copyWith(
          listTransmissionTypesStatus: ListTransmissionTypesStatus.success,
          transmissionTypes: transmissionTypes,
          hasReachedMax: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          listTransmissionTypesStatus: ListTransmissionTypesStatus.failure));
    }
  }

  Future<List<TransmissionType>> _fetchFuelTypes() async {
    QueryBuilder<TransmissionType> query = QueryBuilder(TransmissionType());
    return query.find();
  }

  @override
  ListTransmissionTypesState? fromJson(Map<String, dynamic> json) {
    return ListTransmissionTypesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ListTransmissionTypesState state) {
    return state.toMap();
  }
}
