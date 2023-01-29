import 'package:equatable/equatable.dart';
import 'package:carzoum/carzoum.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required this.junkItApi, required this.authenticationBloc})
      : super(const RegistrationState(gender: Gender.dirty("male"))) {
    on<RegistrationFirstNameChanged>(_onFirstNameChanged);
    on<RegistrationLastNameChanged>(_onLastNameChanged);
    on<RegistrationPhoneChanged>(_onPhoneChanged);
    on<RegistrationEmailChanged>(_onEmailChanged);
    on<RegistrationPasswordChanged>(_onPasswordChanged);
    on<RegistrationGenderChanged>(_onRegistrationGenderChanged);
    on<RegistrationConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SubmitInputsChecked>(_onSubmitInputsChecked);
    on<RegistrationSubmitted>(_onSubmitted);
  }

  final JunkItApi junkItApi;
  final AuthenticationBloc authenticationBloc;

  void _onFirstNameChanged(
    RegistrationFirstNameChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final firstname = FirstName.dirty(event.firstname);
    emit(state.copyWith(
      firstname: firstname,
      status: Formz.validate([
        firstname,
        state.lastname,
        state.phone,
        state.email,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void _onLastNameChanged(
    RegistrationLastNameChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final lastname = LastName.dirty(event.lastname);
    emit(state.copyWith(
      lastname: lastname,
      status: Formz.validate([
        state.firstname,
        lastname,
        state.phone,
        state.email,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void _onPhoneChanged(
    RegistrationPhoneChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final phone = Phone.dirty(event.phone);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([
        state.firstname,
        state.lastname,
        phone,
        state.email,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void _onEmailChanged(
    RegistrationEmailChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.firstname,
        state.lastname,
        state.phone,
        email,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void _onPasswordChanged(
    RegistrationPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.firstname,
        state.lastname,
        state.phone,
        state.email,
        password,
        state.confirmPassword,
      ]),
    ));
  }

  void _onConfirmPasswordChanged(
    RegistrationConfirmPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final confirmPassword = ConfirmPassword.dirty(
      value: event.confirmPassword,
      password: state.password.value,
    );
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate([
        state.firstname,
        state.lastname,
        state.phone,
        state.email,
        state.password,
        confirmPassword,
      ]),
    ));
  }

  void _onSubmitInputsChecked(
    SubmitInputsChecked event,
    Emitter<RegistrationState> emit,
  ) {
    emit(state.copyWith(
      firstname: FirstName.dirty(state.firstname.value),
      lastname: LastName.dirty(state.lastname.value),
      phone: Phone.dirty(state.phone.value),
      email: Email.dirty(state.email.value),
      password: Password.dirty(state.password.value),
      confirmPassword: ConfirmPassword.dirty(
        value: state.confirmPassword.value,
        password: state.password.value,
      ),
    ));
  }

  void _onRegistrationGenderChanged(
    RegistrationGenderChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final gender = Gender.dirty(event.gender);
    emit(state.copyWith(
      gender: gender,
      status: Formz.validate([
        gender,
        state.firstname,
        state.lastname,
        state.phone,
        state.email,
        state.password,
        state.confirmPassword,
      ]),
    ));
  }

  void _onSubmitted(
    RegistrationSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final response = await _signUp(
          firstname: state.firstname.value,
          lastname: state.lastname.value,
          email: state.email.value,
          phone: state.phone.value,
          password: state.password.value,
          gender: state.gender.value.capitalizeFirst,
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on ErrorRegistering catch (e) {
        emit(
          state.copyWith(
            errorMessage: e.getErrorsAsString ?? e.message,
            errors: e.errors,
            status: FormzStatus.submissionFailure,
          ),
        );
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  Future _signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    final userStore = await createStore();

    final user = User(username: email, password: password, email: email);
    user
      ..phone = phone
      ..gender = gender
      ..firstname = firstname
      ..lastname = lastname
      ..store = userStore;
    user.setAdd("devices", []);

    var response = await user.signUp();

    userStore.owner = user;
    var setUserStoreResponse = await userStore.save();

    if (response.success) {
      var result = response.result;
      return true;
    } else {
      print(response.error?.message);
      throw ErrorRegistering(
        message: response.error?.message ==
                'Account already exists for this username.'
            ? 'Account already exists for this email.'
            : response.error?.message,
      );
    }
  }

  Future<Store> createStore() async {
    var store = Store();

    var response = await store.save();

    if (response.success) {
      return response.results?.first;
    } else {
      throw ErrorCreatingUserStore(message: response.error?.message);
    }
  }
}
