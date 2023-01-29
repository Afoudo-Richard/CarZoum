part of 'vehicle_detail_bloc.dart';

abstract class VehicleDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VehiclesDetailSimilarVehiclesFetched extends VehicleDetailEvent {
  final bool refresh;
  VehiclesDetailSimilarVehiclesFetched({this.refresh = false});
}
