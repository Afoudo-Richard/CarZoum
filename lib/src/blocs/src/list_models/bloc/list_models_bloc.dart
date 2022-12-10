import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carzoum/src/data/src/models/src/brand.dart';
import 'package:carzoum/src/data/src/models/src/model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'list_models_event.dart';
part 'list_models_state.dart';

class ListModelsBloc extends HydratedBloc<ListModelsEvent, ListModelsState> {
  ListModelsBloc() : super(const ListModelsState()) {
    on<ModelsFetched>(_onModelsFetched);
    on<SearchModelChanged>(_onSearchModelChanged);
  }

  void _onModelsFetched(
    ModelsFetched event,
    Emitter<ListModelsState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    } else {
      emit(state.copyWith(
        listModelsStatus: ListModelsStatus.initial,
      ));
    }

    try {
      final models = await _fetchModels();

      return emit(
        state.copyWith(
          listModelsStatus: ListModelsStatus.success,
          models: models,
          modelsCopy: models,
          hasReachedMax: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(listModelsStatus: ListModelsStatus.failure));
    }
  }

  Future<List<Model>> _fetchModels() async {
    QueryBuilder<Model> query = QueryBuilder(Model());
    query.includeObject(['brand']);
    return query.find();
  }

  void _onSearchModelChanged(
    SearchModelChanged event,
    Emitter<ListModelsState> emit,
  ) async {
    if (event.brand == null) return;
    if (event.text.isEmpty) {
      return emit(
        state.copyWith(
          models: state.modelsCopy,
        ),
      );
    }
    final models = state.models.where(
      (model) {
        return model.name!.toLowerCase().contains(event.text.toLowerCase()) &&
            model.brand?.name == event.brand!.name;
      },
    ).toList();

    emit(
      state.copyWith(
        models: models,
      ),
    );
  }

  @override
  ListModelsState? fromJson(Map<String, dynamic> json) {
    return ListModelsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ListModelsState state) {
    return state.toMap();
  }
}
