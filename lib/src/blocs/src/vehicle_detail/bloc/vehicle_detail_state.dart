// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vehicle_detail_bloc.dart';

enum ListSimilarVehiclesStatus { initial, success, failure, refresh }

class VehicleDetailState extends Equatable {
  final List<Vehicle> vehicles;
  final ListSimilarVehiclesStatus listSimilarVehiclesStatus;
  final bool hasReachedMax;

  VehicleDetailState({
    this.vehicles = const <Vehicle>[],
    this.listSimilarVehiclesStatus = ListSimilarVehiclesStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [
        vehicles,
        listSimilarVehiclesStatus,
        hasReachedMax,
      ];

  VehicleDetailState copyWith({
    List<Vehicle>? vehicles,
    ListSimilarVehiclesStatus? listSimilarVehiclesStatus,
    bool? hasReachedMax,
  }) {
    return VehicleDetailState(
      vehicles: vehicles ?? this.vehicles,
      listSimilarVehiclesStatus:
          listSimilarVehiclesStatus ?? this.listSimilarVehiclesStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
