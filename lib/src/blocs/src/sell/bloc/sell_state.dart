// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sell_bloc.dart';

enum UploadPhotoStatus { initial, loading, failed, success }

class SellState extends Equatable {
  final Brand? brand;
  final Model? model;
  final int? yearOfManufacture;
  final VehicleLocation vehicleLocation;
  final List<XFile> pickedPhotos;
  final List<Map<String, String>> uploadedPickedPhotos;
  final VehicleMileage vehicleMileage;
  final FuelType? fuelType;
  final ConditionType? conditionType;
  final TransmissionType? transmissionType;
  final bool isRegistered;
  final bool isNegotiable;
  final VehiclePrice vehiclePrice;
  final VehicleDescription vehicleDescription;
  final FormzStatus formStatus;
  final String? errorMessage;
  final UploadPhotoStatus uploadPhotoStatus;

  SellState({
    this.brand,
    this.model,
    this.yearOfManufacture,
    this.vehicleLocation = const VehicleLocation.pure(),
    this.pickedPhotos = const [],
    this.uploadedPickedPhotos = const [],
    this.vehicleMileage = const VehicleMileage.pure(),
    this.fuelType,
    this.conditionType,
    this.transmissionType,
    this.isRegistered = false,
    this.isNegotiable = false,
    this.vehiclePrice = const VehiclePrice.pure(),
    this.vehicleDescription = const VehicleDescription.pure(),
    this.formStatus = FormzStatus.pure,
    this.errorMessage,
    this.uploadPhotoStatus = UploadPhotoStatus.initial,
  });

  @override
  List<Object?> get props {
    return [
      brand,
      model,
      yearOfManufacture,
      vehicleLocation,
      pickedPhotos,
      vehicleMileage,
      fuelType,
      conditionType,
      transmissionType,
      isRegistered,
      isNegotiable,
      vehiclePrice,
      vehicleDescription,
      formStatus,
      errorMessage,
      uploadPhotoStatus,
      uploadedPickedPhotos,
    ];
  }

  SellState copyWith({
    Brand? brand,
    Model? model,
    int? yearOfManufacture,
    VehicleLocation? vehicleLocation,
    List<XFile>? pickedPhotos,
    List<Map<String, String>>? uploadedPickedPhotos,
    VehicleMileage? vehicleMileage,
    FuelType? fuelType,
    ConditionType? conditionType,
    TransmissionType? transmissionType,
    bool? isRegistered,
    bool? isNegotiable,
    VehiclePrice? vehiclePrice,
    VehicleDescription? vehicleDescription,
    FormzStatus? formStatus,
    String? errorMessage,
    UploadPhotoStatus? uploadPhotoStatus,
  }) {
    return SellState(
      brand: brand ?? this.brand,
      model: model ?? this.model,
      yearOfManufacture: yearOfManufacture ?? this.yearOfManufacture,
      vehicleLocation: vehicleLocation ?? this.vehicleLocation,
      pickedPhotos: pickedPhotos ?? this.pickedPhotos,
      uploadedPickedPhotos: uploadedPickedPhotos ?? this.uploadedPickedPhotos,
      vehicleMileage: vehicleMileage ?? this.vehicleMileage,
      fuelType: fuelType ?? this.fuelType,
      conditionType: conditionType ?? this.conditionType,
      transmissionType: transmissionType ?? this.transmissionType,
      isRegistered: isRegistered ?? this.isRegistered,
      isNegotiable: isNegotiable ?? this.isNegotiable,
      vehiclePrice: vehiclePrice ?? this.vehiclePrice,
      vehicleDescription: vehicleDescription ?? this.vehicleDescription,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      uploadPhotoStatus: uploadPhotoStatus ?? this.uploadPhotoStatus,
    );
  }
}
