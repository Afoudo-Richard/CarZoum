part of 'user_image_bloc.dart';

@immutable
abstract class UserImageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectImage extends UserImageEvent {
  final ImageSource imageSource;

  SelectImage({required this.imageSource});
}
