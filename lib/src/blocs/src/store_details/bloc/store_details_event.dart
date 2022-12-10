part of 'store_details_bloc.dart';

@immutable
abstract class StoreDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];

  const StoreDetailsEvent();
}

class StoreNameChanged extends StoreDetailsEvent {
  const StoreNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class StoreLocationChanged extends StoreDetailsEvent {
  const StoreLocationChanged(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}

class StoreAboutChanged extends StoreDetailsEvent {
  const StoreAboutChanged(this.about);

  final String about;

  @override
  List<Object> get props => [about];
}

class StoreDetailsInputsChecked extends StoreDetailsEvent {}

class StoreDetailsSubmitted extends StoreDetailsEvent {}

class StoreDetailsLogoSelected extends StoreDetailsEvent {
  final ImageSource imageSource;

  StoreDetailsLogoSelected({required this.imageSource});
}
