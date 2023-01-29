import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:carzoum/carzoum.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.junkItApi,
    required this.authenticationBloc,
    required this.userBloc,
  }) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<SubmitLoginInputsChecked>(_onSubmitLoginInputsChecked);
    on<LoginSubmitted>(_onSubmitted);
  }

  final JunkItApi junkItApi;
  final AuthenticationBloc authenticationBloc;
  final UserBloc userBloc;

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = LoginPassword.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    ));
  }

  void _onSubmitLoginInputsChecked(
    SubmitLoginInputsChecked event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      email: Email.dirty(state.email.value),
      password: LoginPassword.dirty(state.password.value),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final response = await _login(
          email: state.email.value,
          password: state.password.value,
        );

        User user = await ParseUser.currentUser();

        final userStore = await getUserStore(user);

        user.store = userStore;

        final fcmToken = await FirebaseMessaging.instance.getToken();

        if (user.devices!.where((element) => element == fcmToken).isEmpty &&
            fcmToken != null &&
            user.devices != null) {
          /// Device is empty create a new remote device

          final deviceName = await DeviceHelper.platformName();
          String firebaseCMToken = fcmToken;

          /// update user devices with new device
          // user.("devices", [firebaseCMToken]);
          user.devices = List.of(user.devices!)..add(firebaseCMToken);
          final response = await user.save();
        }

        authenticationBloc.add(
          const AuthenticationChanged(
            authenticated: true,
          ),
        );
        userBloc.add(UserChanged(user: user));

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on ErrorLoggingIn catch (e) {
        emit(state.copyWith(
            errorMessage: e.getErrorsAsString ?? e.message,
            status: FormzStatus.submissionFailure));
      } on ErrorErrorFetchingUserStore catch (e) {
        emit(state.copyWith(
            errorMessage: e.getErrorsAsString ?? e.message,
            status: FormzStatus.submissionFailure));
      } catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
        ));
      }
    }
  }

  Future<Store> getUserStore(User user) async {
    QueryBuilder<Store> query = QueryBuilder(Store())
      ..whereEqualTo('owner', user);

    final response = await query.query();

    if (response.success) {
      var result = response.result[0];
      return result;
    } else {
      throw throw ErrorErrorFetchingUserStore(
        message: response.error?.message,
      );
    }
  }

  Future _login({
    required String email,
    required String password,
  }) async {
    final user = ParseUser(email, password, email);

    var response = await user.login();
    if (response.success) {
      var result = response.result;
      return result;
    } else {
      print(response.error?.exception.toString());

      throw ErrorLoggingIn(
        message: response.error?.message == 'Invalid username/password.'
            ? 'Invalid Email or Password.'
            : response.error?.message,
      );
    }
  }

  // Future<void> goToFacebookLogin() async {
  //   final facebookLogin = FacebookLogin();
  //   final result = await facebookLogin.logIn(['email']);

  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final ParseResponse response = await ParseUser.loginWith(
  //           'facebook',
  //           facebook(result.accessToken.token, result.accessToken.userId,
  //               result.accessToken.expires));

  //       if (response.success) {
  //         // User is logged in, test with ParseUser.currentUser()
  //       }
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       // User cancelled
  //       break;
  //     case FacebookLoginStatus.error:
  //       // Error
  //       break;
  //   }
  // }
}
