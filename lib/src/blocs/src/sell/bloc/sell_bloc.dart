import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:carzoum/src/data/src/formz/formz.dart';
import 'package:carzoum/src/data/src/models/models.dart';
import 'package:carzoum/src/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'sell_event.dart';
part 'sell_state.dart';

class SellBloc extends Bloc<SellEvent, SellState> {
  SellBloc({required this.listVehiclesBloc, required this.userBloc})
      : super(SellState()) {
    on<VehicleBrandChanged>(_onVehicleBrandChanged);
    on<VehicleModelChanged>(_onVehicleModelChanged);
    on<VehicleYearOfManufactureChanged>(_onVehicleYearOfManufactureChanged);
    on<VehicleFuelTypeChanged>(_onVehicleFuelTypeChanged);
    on<VehicleTransmissionTypeChanged>(_onVehicleTransmissionTypeChanged);
    on<VehicleConditionTypeChanged>(_onVehicleConditionTypeChanged);
    on<VehicleImagesSelected>(_onVehicleImagesSelected);
    on<VehiclePriceChanged>(_onVehiclePriceChanged);
    on<VehicleDescriptionChanged>(_onVehicleDescriptionChanged);
    on<VehicleMileageChanged>(_onVehicleMileageChanged);
    on<VehicleLocationChanged>(_onVehicleLocationChanged);
    on<VehicleIsRegisteredChanged>(_onVehicleIsRegisteredChanged);
    on<VehicleIsNegotiableChanged>(_onVehicleIsNegotiableChanged);
    on<VehicleSelectionCleared>(_onVehicleSelectionCleared);
    on<VehicleClearAllVehiclePhotos>(_onVehicleClearAllVehiclePhotos);
    on<SubmitVehicleInputsChecked>(_onSubmitVehicleInputsChecked);
    on<VehicleSubmitted>(_onVehicleSubmitted);
  }

  final ListVehiclesBloc listVehiclesBloc;
  final UserBloc userBloc;

  void _onVehicleSelectionCleared(
    VehicleSelectionCleared event,
    Emitter<SellState> emit,
  ) {
    SellState newSellState = SellState();
    emit(newSellState);
    // emit(
    //   state.copyWith(
    //     brand: null,
    //     model: null,
    //     yearOfManufacture: null,
    //     conditionType: null,
    //     transmissionType: null,
    //     fuelType: null,
    //     vehicleMileage: const VehicleMileage.pure(),
    //     vehicleDescription: const VehicleDescription.pure(),
    //     vehicleLocation: const VehicleLocation.pure(),
    //     vehiclePrice: const VehiclePrice.pure(),
    //     pickedPhotos: [],
    //     uploadedPickedPhotos: [],
    //     uploadPhotoStatus: UploadPhotoStatus.initial,
    //     isNegotiable: false,
    //     isRegistered: false,
    //   ),
    // );
  }

  void _onVehicleBrandChanged(
    VehicleBrandChanged event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        brand: event.brand,
        model: null,
        yearOfManufacture: null,
        fuelType: null,
        conditionType: null,
        transmissionType: null,
      ),
    );
  }

  void _onVehicleModelChanged(
    VehicleModelChanged event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        brand: state.brand,
        model: event.model,
        yearOfManufacture: null,
      ),
    );
  }

  void _onVehicleYearOfManufactureChanged(
    VehicleYearOfManufactureChanged event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        yearOfManufacture: event.year,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleFuelTypeChanged(
    VehicleFuelTypeChanged event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        fuelType: event.fuelType,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleTransmissionTypeChanged(
    VehicleTransmissionTypeChanged event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        transmissionType: event.transmissionType,
        conditionType: state.conditionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleConditionTypeChanged(
    VehicleConditionTypeChanged event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        conditionType: event.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehiclePriceChanged(
    VehiclePriceChanged event,
    Emitter<SellState> emit,
  ) {
    final vehiclePrice = VehiclePrice.dirty(event.price);
    emit(
      state.copyWith(
        vehiclePrice: vehiclePrice,
        formStatus: Formz.validate([
          state.vehicleDescription,
          state.vehicleMileage,
          state.vehicleLocation,
          vehiclePrice,
        ]),
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleDescriptionChanged(
    VehicleDescriptionChanged event,
    Emitter<SellState> emit,
  ) {
    final vehicleDescription = VehicleDescription.dirty(event.description);
    emit(
      state.copyWith(
        vehicleDescription: vehicleDescription,
        formStatus: Formz.validate([
          state.vehiclePrice,
          state.vehicleMileage,
          state.vehicleLocation,
          vehicleDescription,
        ]),
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleMileageChanged(
    VehicleMileageChanged event,
    Emitter<SellState> emit,
  ) {
    final vehicleMileage = VehicleMileage.dirty(event.mileage);
    emit(
      state.copyWith(
        vehicleMileage: vehicleMileage,
        formStatus: Formz.validate([
          state.vehiclePrice,
          vehicleMileage,
          state.vehicleLocation,
          state.vehicleDescription,
        ]),
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleLocationChanged(
    VehicleLocationChanged event,
    Emitter<SellState> emit,
  ) {
    final vehicleLocation = VehicleLocation.dirty(event.location);
    emit(
      state.copyWith(
        vehicleLocation: vehicleLocation,
        formStatus: Formz.validate([
          state.vehiclePrice,
          state.vehicleMileage,
          vehicleLocation,
          state.vehicleDescription,
        ]),
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleIsRegisteredChanged(
    VehicleIsRegisteredChanged event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        isRegistered: event.isRegistered,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleIsNegotiableChanged(
    VehicleIsNegotiableChanged event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        isNegotiable: event.isNegotiable,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleClearAllVehiclePhotos(
    VehicleClearAllVehiclePhotos event,
    Emitter<SellState> emit,
  ) {
    emit(
      state.copyWith(
        pickedPhotos: [],
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
        brand: state.brand,
      ),
    );
  }

  void _onVehicleImagesSelected(
    VehicleImagesSelected event,
    Emitter<SellState> emit,
  ) async {
    try {
      List<XFile> pickedFile = await ImagePicker().pickMultiImage();

      if (pickedFile == null) throw Exception("Unable to get image");

      emit(
        state.copyWith(
          pickedPhotos: List.of(state.pickedPhotos)..addAll(pickedFile),
          uploadPhotoStatus: UploadPhotoStatus.loading,
          conditionType: state.conditionType,
          transmissionType: state.transmissionType,
          fuelType: state.fuelType,
          yearOfManufacture: state.yearOfManufacture,
          model: state.model,
          brand: state.brand,
        ),
      );

      try {
        List<Map<String, String>> images = [];
        if (state.pickedPhotos != null) {
          images = await uploadPickedPhotos();
          print(images);
        }
        emit(
          state.copyWith(
            uploadPhotoStatus: UploadPhotoStatus.success,
            uploadedPickedPhotos: List.of(state.uploadedPickedPhotos)
              ..addAll(images),
            conditionType: state.conditionType,
            transmissionType: state.transmissionType,
            fuelType: state.fuelType,
            yearOfManufacture: state.yearOfManufacture,
            model: state.model,
            brand: state.brand,
          ),
        );
      } catch (e) {}
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } catch (_) {
      print("No file picked");
    }
  }

  void _onSubmitVehicleInputsChecked(
    SubmitVehicleInputsChecked event,
    Emitter<SellState> emit,
  ) {
    emit(state.copyWith(
      vehicleDescription:
          VehicleDescription.dirty(state.vehicleDescription.value),
      vehicleLocation: VehicleLocation.dirty(state.vehicleLocation.value),
      vehicleMileage: VehicleMileage.dirty(state.vehicleMileage.value),
      vehiclePrice: VehiclePrice.dirty(state.vehiclePrice.value),
      conditionType: state.conditionType,
      transmissionType: state.transmissionType,
      fuelType: state.fuelType,
      yearOfManufacture: state.yearOfManufacture,
      model: state.model,
      brand: state.brand,
    ));
  }

  void _onVehicleSubmitted(
    VehicleSubmitted event,
    Emitter<SellState> emit,
  ) async {
    if (state.formStatus.isValidated) {
      emit(state.copyWith(
        formStatus: FormzStatus.submissionInProgress,
        brand: state.brand,
        conditionType: state.conditionType,
        transmissionType: state.transmissionType,
        fuelType: state.fuelType,
        yearOfManufacture: state.yearOfManufacture,
        model: state.model,
      ));
      try {
        final response = await addVehicle();

        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
        add(VehicleSelectionCleared());
        listVehiclesBloc.add(
          VehiclesFetched(
            refresh: true,
          ),
        );
      } on ErrorAddingVehicle catch (e) {
        emit(state.copyWith(
          errorMessage: e.getErrorsAsString ?? e.message,
          formStatus: FormzStatus.submissionFailure,
          conditionType: state.conditionType,
          transmissionType: state.transmissionType,
          fuelType: state.fuelType,
          yearOfManufacture: state.yearOfManufacture,
          model: state.model,
          brand: state.brand,
        ));
      } catch (_) {
        emit(state.copyWith(
          formStatus: FormzStatus.submissionFailure,
          conditionType: state.conditionType,
          transmissionType: state.transmissionType,
          fuelType: state.fuelType,
          yearOfManufacture: state.yearOfManufacture,
          model: state.model,
          brand: state.brand,
        ));
      }
    }
  }

  Future<List<Map<String, String>>> uploadPickedPhotos() async {
    List<Map<String, String>> uploadedImageUrlLink = [];

    try {
      for (var image in state.pickedPhotos as List<XFile>) {
        ParseFileBase? parseFile = ParseFile(File(image.path));
        await parseFile.save();

        uploadedImageUrlLink.add({
          "localImage": "${image.name} - ${image.path}",
          "uploadedImage":
              parseFile.url ?? "https://ui-avatars.com/api/?name=C+S"
        });
      }

      return uploadedImageUrlLink;
    } catch (e) {
      throw "Unable to upload file";
    }
  }

  Future addVehicle() async {
    final List<String> uploadedImageUrlLink = [];
    final uploadedPickedPhotos = List.of(state.uploadedPickedPhotos);

    uploadedPickedPhotos.forEach((image) {
      uploadedImageUrlLink.add(image['uploadedImage']!);
    });

    try {
      print(state.vehicleMileage.value);
      print(state.vehicleMileage.value.isEmpty);

      var vehicle = Vehicle()
        ..brand = state.brand
        ..model = state.model
        ..yearOfManufacture = state.yearOfManufacture
        ..fuelType = state.fuelType
        ..transmissionType = state.transmissionType
        ..conditionType = state.conditionType
        ..location = state.vehicleLocation.value
        ..description = state.vehicleDescription.value
        ..price = int.parse(state.vehiclePrice.value)
        ..photos = uploadedImageUrlLink
        ..isRegistered = state.isRegistered
        ..isNegotiable = state.isNegotiable
        ..isVerified = false
        ..status = AdvertStatus.reviewing.name
        ..views = 0
        ..store = userBloc.state.user?.store
        ..user = userBloc.state.user;

      // if (state.vehicleMileage.value.isNotEmpty) {
      //   vehicle.mileage = int.parse(state.vehicleMileage.value);
      // }

      var response = await vehicle.create();

      if (response.success) {
      } else {
        print("An error occured here : ${response.toString()}");
        //throw ErrorAddingVehicle(message: response.error?.message);
      }
    } catch (e) {
      print("Unable to upload vehicle:${e.toString()}");
      throw ErrorAddingVehicle(
          message: "Unable to upload vehicle:${e.toString()}");
    }
  }
}
