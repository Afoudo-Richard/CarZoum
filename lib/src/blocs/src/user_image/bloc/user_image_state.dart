// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_image_bloc.dart';

enum UserImageStatus { initial, loading, success, failure }

class UserImageState extends Equatable {
  final XFile? pickedFile;
  final UserImageStatus userImageStatus;
  UserImageState({
    this.pickedFile,
    this.userImageStatus = UserImageStatus.initial,
  });

  UserImageState copyWith({
    XFile? pickedFile,
    UserImageStatus? userImageStatus,
  }) {
    return UserImageState(
      pickedFile: pickedFile ?? this.pickedFile,
      userImageStatus: userImageStatus ?? this.userImageStatus,
    );
  }

  @override
  List<Object?> get props => [
        pickedFile,
        userImageStatus,
      ];
}
