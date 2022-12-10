import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'refresh_checker_event.dart';
part 'refresh_checker_state.dart';

class RefreshCheckerBloc
    extends HydratedBloc<RefreshCheckerEvent, RefreshCheckerState> {
  RefreshCheckerBloc({
    required this.listBrandsBloc,
    required this.listModelsBloc,
    required this.listConditionTypesBloc,
    required this.listTransmissionTypesBloc,
    required this.listFuelTypesBloc,
  }) : super(RefreshCheckerState()) {
    on<RefreshChecked>(_onRefreshChecked);
  }

  final ListBrandsBloc listBrandsBloc;
  final ListModelsBloc listModelsBloc;
  final ListConditionTypesBloc listConditionTypesBloc;
  final ListTransmissionTypesBloc listTransmissionTypesBloc;
  final ListFuelTypesBloc listFuelTypesBloc;

  void _onRefreshChecked(
    RefreshChecked event,
    Emitter<RefreshCheckerState> emit,
  ) async {
    try {
      List<Bloc> blocs = <Bloc>[];
      final configs = await _fetchAppConfig();

      final brandChangeCount = configs['brandChangeCount'];
      final modelChangeCount = configs['modelChangeCount'];
      final fuelTypeChangeCount = configs['fuelTypeChangeCount'];
      final conditionTypeChangeCount = configs['conditionTypeChangeCount'];
      final transmissionTypeCount = configs['transmissionTypeCount'];

      print(configs);

      if (brandChangeCount != null) {
        if (state.brandChangeCount < brandChangeCount) {
          blocs.add(listBrandsBloc);
        }
      }

      if (modelChangeCount != null) {
        if (state.modelChangeCount < modelChangeCount) {
          blocs.add(listModelsBloc);
        }
      }

      if (fuelTypeChangeCount != null) {
        if (state.fuelTypeChangeCount < fuelTypeChangeCount) {
          blocs.add(listFuelTypesBloc);
        }
      }

      if (conditionTypeChangeCount != null) {
        if (state.conditionTypeChangeCount < conditionTypeChangeCount) {
          blocs.add(listConditionTypesBloc);
        }
      }

      if (transmissionTypeCount != null) {
        if (state.transmissionTypeCount < transmissionTypeCount) {
          blocs.add(listTransmissionTypesBloc);
        }
      }

      for (var item in blocs) {
        if (item is ListBrandsBloc) {
          await item
            ..add(BrandsFetched(refresh: true));
        }
        if (item is ListModelsBloc) {
          await item
            ..add(ModelsFetched(refresh: true));
        }
        if (item is ListConditionTypesBloc) {
          await item
            ..add(ConditionTypesFetched(refresh: true));
        }
        if (item is ListFuelTypesBloc) {
          await item
            ..add(FuelTypesFetched(refresh: true));
        }
        if (item is ListTransmissionTypesBloc) {
          await item
            ..add(TransmissionTypesFetched(refresh: true));
        }
      }

      emit(
        state.copyWith(
          refreshCheckerStatus: RefreshCheckerStatus.success,
          brandChangeCount: brandChangeCount ?? 0,
          modelChangeCount: modelChangeCount ?? 0,
          fuelTypeChangeCount: fuelTypeChangeCount ?? 0,
          conditionTypeChangeCount: conditionTypeChangeCount ?? 0,
          transmissionTypeCount: transmissionTypeCount ?? 0,
        ),
      );
    } on ErrorFetchingAppConfig {
    } catch (e) {
      emit(
        state.copyWith(
          refreshCheckerStatus: RefreshCheckerStatus.failure,
        ),
      );
    }
  }

  Future _fetchAppConfig() async {
    var response = await ParseConfig().getConfigs();

    if (response.success) {
      return response.result;
    } else {
      throw ErrorFetchingAppConfig();
    }
  }

  @override
  RefreshCheckerState? fromJson(Map<String, dynamic> json) {
    return RefreshCheckerState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(RefreshCheckerState state) {
    return state.toMap();
  }
}
