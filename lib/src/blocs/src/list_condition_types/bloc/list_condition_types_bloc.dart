import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'list_condition_types_event.dart';
part 'list_condition_types_state.dart';

class ListConditionTypesBloc
    extends HydratedBloc<ListConditionTypesEvent, ListConditionTypesState> {
  ListConditionTypesBloc() : super(const ListConditionTypesState()) {
    on<ConditionTypesFetched>(_onConditionTypesFetched);
  }

  void _onConditionTypesFetched(
    ConditionTypesFetched event,
    Emitter<ListConditionTypesState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }

    try {
      final conditionTypes = await _fetchFuelTypes();

      return emit(
        state.copyWith(
          listConditionTypesStatus: ListConditionTypesStatus.success,
          conditionTypes: conditionTypes,
          hasReachedMax: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          listConditionTypesStatus: ListConditionTypesStatus.failure));
    }
  }

  Future<List<ConditionType>> _fetchFuelTypes() async {
    QueryBuilder<ConditionType> query = QueryBuilder(ConditionType());
    return query.find();
  }

  @override
  ListConditionTypesState? fromJson(Map<String, dynamic> json) {
    return ListConditionTypesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ListConditionTypesState state) {
    return state.toMap();
  }
}
