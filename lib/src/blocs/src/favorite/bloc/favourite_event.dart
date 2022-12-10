part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouriteVehicleAdded extends FavouriteEvent {
  final Vehicle vehicle;
  FavouriteVehicleAdded({
    required this.vehicle,
  });

  @override
  List<Object?> get props => [vehicle];
}

class FavouriteVehicleRemoved extends FavouriteEvent {
  final Vehicle vehicle;
  FavouriteVehicleRemoved({
    required this.vehicle,
  });

  @override
  List<Object?> get props => [vehicle];
}

class ClearedFavourite extends FavouriteEvent {}
