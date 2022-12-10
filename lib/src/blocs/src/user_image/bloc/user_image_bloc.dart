import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:carzoum/src/data/data.dart';

part 'user_image_event.dart';
part 'user_image_state.dart';

class UserImageBloc extends Bloc<UserImageEvent, UserImageState> {
  UserImageBloc({
    required this.authenticationBloc,
    required this.userBloc,
  }) : super(UserImageState()) {
    on<SelectImage>(_onSelectImage);
  }

  final AuthenticationBloc authenticationBloc;
  final UserBloc userBloc;

  void _onSelectImage(
    SelectImage event,
    Emitter<UserImageState> emit,
  ) async {
    try {
      var pickedFile =
          (await ImagePicker().pickImage(source: event.imageSource));

      if (pickedFile == null) throw Exception("Unable to get image");
      ParseFileBase? parseFile = ParseFile(File(pickedFile.path));
      emit(state.copyWith(userImageStatus: UserImageStatus.loading));

      await parseFile.save();
      User currentUser = userBloc.state.user ?? User();

      // replace with normal user
      User parseUser = await ParseUser.currentUser();

      parseUser.set(
        'profileImage',
        parseFile.url,
      );
      final response = await parseUser.save();

      // final user = User()
      //   ..objectId = currentUser.objectId
      //   ..set(
      //     'profileImage',
      //     parseFile.url,
      //   );
      // final response = await user.save();

      if (response.success) {
        currentUser.profileImage = parseFile.url;
        authenticationBloc.add(
          AuthenticationUserChanged(
            user: currentUser,
          ),
        );
        emit(
          state.copyWith(
            userImageStatus: UserImageStatus.success,
          ),
        );
      }
      emit(state.copyWith(pickedFile: pickedFile));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      emit(
        state.copyWith(
          userImageStatus: UserImageStatus.failure,
        ),
      );
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  void selectImage(ImageSource imgsource) async {
    try {
      var pickedFile = (await ImagePicker().pickImage(source: imgsource))!;
      emit(state.copyWith(pickedFile: pickedFile));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } finally {
      print("Unable to open images");
    }
  }
}
