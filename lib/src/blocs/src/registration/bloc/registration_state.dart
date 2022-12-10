// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_bloc.dart';

enum genderType { male, female, other }

class RegistrationState extends Equatable {
  const RegistrationState({
    this.status = FormzStatus.pure,
    this.firstname = const FirstName.pure(),
    this.lastname = const LastName.pure(),
    this.phone = const Phone.pure(),
    this.email = const Email.pure(),
    this.gender = const Gender.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.errorMessage,
    this.errors,
  });

  final FormzStatus status;
  final FirstName firstname;
  final LastName lastname;
  final Phone phone;
  final Email email;
  final Gender gender;
  final Password password;
  final ConfirmPassword confirmPassword;
  final String? errorMessage;
  final Map<String, dynamic>? errors;

  RegistrationState copyWith({
    FormzStatus? status,
    FirstName? firstname,
    LastName? lastname,
    Phone? phone,
    Email? email,
    Gender? gender,
    Password? password,
    ConfirmPassword? confirmPassword,
    String? errorMessage,
    Map<String, dynamic>? errors,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [
        status,
        firstname,
        lastname,
        phone,
        email,
        password,
        confirmPassword,
        gender,
      ];
}
