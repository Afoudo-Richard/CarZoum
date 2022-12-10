part of 'list_vehicles_bloc.dart';

enum ListVehiclesStatus { initial, success, failure, refresh }

class ListVehiclesState extends Equatable {
  final List<Vehicle> vehicles;
  final ListVehiclesStatus listVehiclesStatus;
  final bool hasReachedMax;

  ListVehiclesState({
    this.vehicles = const <Vehicle>[],
    this.listVehiclesStatus = ListVehiclesStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [
        vehicles,
        listVehiclesStatus,
        hasReachedMax,
      ];

  ListVehiclesState copyWith({
    List<Vehicle>? vehicles,
    ListVehiclesStatus? listVehiclesStatus,
    bool? hasReachedMax,
  }) {
    return ListVehiclesState(
      vehicles: vehicles ?? this.vehicles,
      listVehiclesStatus: listVehiclesStatus ?? this.listVehiclesStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
