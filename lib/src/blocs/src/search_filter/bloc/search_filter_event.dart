part of 'search_filter_bloc.dart';

@immutable
abstract class SearchFilterEvent extends Equatable {
  const SearchFilterEvent();
  @override
  List<Object?> get props => [];
}

class SearchFilterVehicleBrandChanged extends SearchFilterEvent {
  const SearchFilterVehicleBrandChanged(this.brand);

  final Brand? brand;
  @override
  List<Object?> get props => [brand];
}

class SearchFilterVehicleModelChanged extends SearchFilterEvent {
  const SearchFilterVehicleModelChanged(this.model);

  final Model? model;
}

class SearchFilterVehicleYearOfManufactureChanged extends SearchFilterEvent {
  const SearchFilterVehicleYearOfManufactureChanged(
      {required this.startYear, required this.endYear});

  final int startYear;
  final int endYear;
}

class SearchFilterVehicleFuelTypeChanged extends SearchFilterEvent {
  const SearchFilterVehicleFuelTypeChanged(this.fuelType);

  final FuelType? fuelType;
}

class SearchFilterVehicleConditionTypeChanged extends SearchFilterEvent {
  const SearchFilterVehicleConditionTypeChanged(this.conditionType);

  final ConditionType? conditionType;
}

class SearchFilterVehicleTransmissionTypeChanged extends SearchFilterEvent {
  const SearchFilterVehicleTransmissionTypeChanged(this.transmissionType);

  final TransmissionType transmissionType;

  @override
  List<Object> get props => [transmissionType];
}

class SearchFilterVehiclePriceRangeChanged extends SearchFilterEvent {
  const SearchFilterVehiclePriceRangeChanged({
    required this.startPrice,
    required this.endPrice,
  });

  final int startPrice;
  final int endPrice;
}

class SearchFilterVehicleMileageRangeChanged extends SearchFilterEvent {
  const SearchFilterVehicleMileageRangeChanged({
    required this.startMileage,
    required this.endMileage,
  });
  final int startMileage;
  final int endMileage;
}

class SearchFilterVehicleIsRegisteredChanged extends SearchFilterEvent {
  const SearchFilterVehicleIsRegisteredChanged(this.isRegistered);

  final bool isRegistered;

  @override
  List<Object> get props => [isRegistered];
}

class SearchFilterVehicleIsNegotiableChanged extends SearchFilterEvent {
  const SearchFilterVehicleIsNegotiableChanged(this.isNegotiable);

  final bool isNegotiable;

  @override
  List<Object> get props => [isNegotiable];
}

class SearchFilterVehiclesFetched extends SearchFilterEvent {
  final bool refresh;
  SearchFilterVehiclesFetched({this.refresh = false});
}

class SearchFilterResetted extends SearchFilterEvent {}

class SearchFilterSubmitted extends SearchFilterEvent {
  final bool refresh;
  final bool isFromButton;
  SearchFilterSubmitted({this.refresh = false, this.isFromButton = true});
}
