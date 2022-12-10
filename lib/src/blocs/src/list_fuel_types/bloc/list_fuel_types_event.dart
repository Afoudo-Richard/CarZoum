part of 'list_fuel_types_bloc.dart';

abstract class ListFuelTypesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FuelTypesFetched extends ListFuelTypesEvent {
  final bool refresh;
  FuelTypesFetched({this.refresh = false});
}
