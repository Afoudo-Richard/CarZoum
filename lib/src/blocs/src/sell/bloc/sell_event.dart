part of 'sell_bloc.dart';

abstract class SellEvent extends Equatable {
  const SellEvent();

  @override
  List<Object> get props => [];
}

class VehicleBrandChanged extends SellEvent {
  const VehicleBrandChanged(this.brand);

  final Brand? brand;
}

class VehicleModelChanged extends SellEvent {
  const VehicleModelChanged(this.model);

  final Model model;

  @override
  List<Object> get props => [model];
}

class VehicleYearOfManufactureChanged extends SellEvent {
  const VehicleYearOfManufactureChanged(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

class VehicleFuelTypeChanged extends SellEvent {
  const VehicleFuelTypeChanged(this.fuelType);

  final FuelType fuelType;

  @override
  List<Object> get props => [fuelType];
}

class VehicleConditionTypeChanged extends SellEvent {
  const VehicleConditionTypeChanged(this.conditionType);

  final ConditionType conditionType;

  @override
  List<Object> get props => [conditionType];
}

class VehicleTransmissionTypeChanged extends SellEvent {
  const VehicleTransmissionTypeChanged(this.transmissionType);

  final TransmissionType transmissionType;

  @override
  List<Object> get props => [transmissionType];
}

class VehiclePriceChanged extends SellEvent {
  const VehiclePriceChanged(this.price);

  final String price;

  @override
  List<Object> get props => [price];
}

class VehicleDescriptionChanged extends SellEvent {
  const VehicleDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class VehicleMileageChanged extends SellEvent {
  const VehicleMileageChanged(this.mileage);

  final String mileage;

  @override
  List<Object> get props => [mileage];
}

class VehicleLocationChanged extends SellEvent {
  const VehicleLocationChanged(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}

class VehicleIsRegisteredChanged extends SellEvent {
  const VehicleIsRegisteredChanged(this.isRegistered);

  final bool isRegistered;

  @override
  List<Object> get props => [isRegistered];
}

class VehicleIsNegotiableChanged extends SellEvent {
  const VehicleIsNegotiableChanged(this.isNegotiable);

  final bool isNegotiable;

  @override
  List<Object> get props => [isNegotiable];
}

class VehicleImagesSelected extends SellEvent {}

class VehicleSelectionCleared extends SellEvent {}

class SubmitVehicleInputsChecked extends SellEvent {}

class VehicleClearAllVehiclePhotos extends SellEvent {}

class VehicleSubmitted extends SellEvent {}
