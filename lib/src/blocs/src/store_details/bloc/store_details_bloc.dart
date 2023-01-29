import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

part 'store_details_event.dart';
part 'store_details_state.dart';

class StoreDetailsBloc extends Bloc<StoreDetailsEvent, StoreDetailsState> {
  StoreDetailsBloc({required this.userBloc})
      : super(
          StoreDetailsState(
            storeName:
                StoreName.dirty(userBloc.state.user?.store?.name ?? "N/A"),
            storeLocation: StoreLocation.dirty(
              userBloc.state.user?.store?.location ?? "N/A",
            ),
            storeAbout: StoreAbout.dirty(
              userBloc.state.user?.store?.about ?? "N/A",
            ),
            storeWhatsappPhone:
                StoreWhatsappPhone.dirty(userBloc.state.user?.phone ?? ""),
          ),
        ) {
    on<StoreNameChanged>(_onStoreNameChanged);
    on<StoreLocationChanged>(_onStoreLocationChanged);
    on<StoreAboutChanged>(_onStoreAboutChanged);
    on<StoreDetailsInputsChecked>(_onStoreDetailsInputsChecked);
    on<StoreDetailsLogoSelected>(_onStoreDetailsLogoSelected);
    on<StoreDetailsSubmitted>(_onStoreDetailsSubmitted);
  }

  final UserBloc userBloc;

  void _onStoreNameChanged(
    StoreNameChanged event,
    Emitter<StoreDetailsState> emit,
  ) {
    final storeName = StoreName.dirty(event.name);
    emit(
      state.copyWith(
        storeName: storeName,
        formStatus: Formz.validate([
          storeName,
          state.storeLocation,
          state.storeAbout,
        ]),
      ),
    );
  }

  void _onStoreLocationChanged(
    StoreLocationChanged event,
    Emitter<StoreDetailsState> emit,
  ) {
    final storeLocation = StoreLocation.dirty(event.location);
    emit(
      state.copyWith(
        storeLocation: storeLocation,
        formStatus: Formz.validate([
          state.storeName,
          storeLocation,
          state.storeAbout,
        ]),
      ),
    );
  }

  void _onStoreAboutChanged(
    StoreAboutChanged event,
    Emitter<StoreDetailsState> emit,
  ) {
    final storeAbout = StoreAbout.dirty(event.about);
    emit(
      state.copyWith(
        storeAbout: storeAbout,
        formStatus: Formz.validate([
          state.storeName,
          state.storeLocation,
          storeAbout,
        ]),
      ),
    );
  }

  void _onStoreDetailsInputsChecked(
    StoreDetailsInputsChecked event,
    Emitter<StoreDetailsState> emit,
  ) {
    emit(
      state.copyWith(
        storeName: StoreName.dirty(state.storeName.value),
        storeAbout: StoreAbout.dirty(state.storeAbout.value),
        storeLocation: StoreLocation.dirty(state.storeLocation.value),
      ),
    );
  }

  void _onStoreDetailsLogoSelected(
    StoreDetailsLogoSelected event,
    Emitter<StoreDetailsState> emit,
  ) async {
    try {
      var pickedFile =
          (await ImagePicker().pickImage(source: event.imageSource));

      if (pickedFile == null) throw Exception("Unable to get image");
      ParseFileBase? parseFile = ParseFile(File(pickedFile.path));
      emit(
        state.copyWith(
          storeDetailsLogoStatus: StoreDetailsLogoStatus.loading,
        ),
      );
      await parseFile.save();
      User currentUser = userBloc.state.user ?? User();
      Store userStore = currentUser.store ?? Store();

      userStore.profileImage = parseFile.url;

      final response = await userStore.save();

      if (response.success) {
        currentUser.store = userStore;
        userBloc.add(
          UserChanged(
            user: currentUser,
          ),
        );
        emit(
          state.copyWith(
            storeDetailsLogoStatus: StoreDetailsLogoStatus.success,
          ),
        );
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      emit(
        state.copyWith(
          storeDetailsLogoStatus: StoreDetailsLogoStatus.failure,
        ),
      );
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  void _onStoreDetailsSubmitted(
    StoreDetailsSubmitted event,
    Emitter<StoreDetailsState> emit,
  ) async {
    if (state.formStatus.isValidated) {
      emit(
        state.copyWith(
          formStatus: FormzStatus.submissionInProgress,
        ),
      );

      try {
        final response = await _updateStore();
        User? user = userBloc.state.user;
        user?.store = response;
        userBloc.add(
          UserChanged(
            user: user,
          ),
        );
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
          ),
        );
      } catch (e) {
        emit(state.copyWith(
          formStatus: FormzStatus.submissionFailure,
        ));
      }
    }
  }

  Future<Store> _updateStore() async {
    var store = Store()
      ..objectId = userBloc.state.user?.store?.objectId
      ..name = state.storeName.value
      ..location = state.storeLocation.value
      ..about = state.storeAbout.value;

    var response = await store.save();

    if (response.success) {
      return store;
    } else {
      throw ErrorAddingVehicle(message: response.error?.message);
    }
  }
}
