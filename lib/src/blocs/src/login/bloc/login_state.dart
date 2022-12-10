part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const LoginPassword.pure(),
    this.errorMessage,
  });

  final FormzStatus status;
  final Email email;
  final LoginPassword password;
  final String? errorMessage;

  LoginState copyWith({
    FormzStatus? status,
    Email? email,
    LoginPassword? password,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, email, password];
}
