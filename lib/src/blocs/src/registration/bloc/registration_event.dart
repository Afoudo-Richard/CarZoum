part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationFirstNameChanged extends RegistrationEvent {
  const RegistrationFirstNameChanged(this.firstname);

  final String firstname;

  @override
  List<Object> get props => [firstname];
}

class RegistrationLastNameChanged extends RegistrationEvent {
  const RegistrationLastNameChanged(this.lastname);

  final String lastname;

  @override
  List<Object> get props => [lastname];
}

class RegistrationPhoneChanged extends RegistrationEvent {
  const RegistrationPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class RegistrationEmailChanged extends RegistrationEvent {
  const RegistrationEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RegistrationPasswordChanged extends RegistrationEvent {
  const RegistrationPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegistrationConfirmPasswordChanged extends RegistrationEvent {
  const RegistrationConfirmPasswordChanged(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class RegistrationGenderChanged extends RegistrationEvent {
  const RegistrationGenderChanged(this.gender);

  final String gender;

  @override
  List<Object> get props => [gender];
}

class SubmitInputsChecked extends RegistrationEvent {}

class RegistrationSubmitted extends RegistrationEvent {}
