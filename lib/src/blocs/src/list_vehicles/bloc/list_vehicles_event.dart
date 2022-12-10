part of 'list_vehicles_bloc.dart';

abstract class ListVehiclesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VehiclesFetched extends ListVehiclesEvent {
  final bool refresh;
  VehiclesFetched({this.refresh = false});
}

class VehicleViewAdded extends ListVehiclesEvent {
  final Vehicle vehicle;

  VehicleViewAdded({required this.vehicle});
}
