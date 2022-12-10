import 'dart:convert';
import 'package:carzoum/carzoum.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:equatable/equatable.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends HydratedBloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteState()) {
    on<FavouriteVehicleAdded>(_onFavouriteVehicleAdded);
    on<FavouriteVehicleRemoved>(_onFavouriteVehicleRemoved);
    on<ClearedFavourite>(_onClearedFavourite);
  }

  void _onFavouriteVehicleAdded(
      FavouriteVehicleAdded event, Emitter<FavouriteState> emit) {
    state.vehicleInFavourite(event.vehicle)
        ? emit(
            state.copyWith(
              favouriteStatus: FavouriteStatus.vehicleExist,
            ),
          )
        : emit(
            state.copyWith(
              vehicles: List.of(state.vehicles)..add(event.vehicle),
              favouriteStatus: FavouriteStatus.vehicleAdded,
            ),
          );
  }

  void _onFavouriteVehicleRemoved(
      FavouriteVehicleRemoved event, Emitter<FavouriteState> emit) {
    emit(
      state.copyWith(
        vehicles: List.of(state.vehicles)..remove(event.vehicle),
        favouriteStatus: FavouriteStatus.vehicleRemoved,
      ),
    );
  }

  void _onClearedFavourite(
      ClearedFavourite event, Emitter<FavouriteState> emit) {
    emit(
      state.copyWith(
        vehicles: List.of(state.vehicles)..clear(),
        favouriteStatus: FavouriteStatus.cleared,
      ),
    );
  }

  @override
  FavouriteState? fromJson(Map<String, dynamic> json) {
    return FavouriteState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(FavouriteState state) {
    return state.toMap();
  }
}
