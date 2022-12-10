import 'dart:convert';

// import 'package:authentication_repository/authentication_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:carzoum/src/data/data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<AuthenticationChanged>(_onAuthenticationChanged);
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationChecker>(_onAuthenticationChecker);
    on<AuthenticationHasWalkedThroughChanged>(
        _onAuthenticationHasWalkedThroughChanged);
    on<AuthenticationSignInAnonymous>(_onAuthenticationSignInAnonymous);
  }

  void _onAuthenticationHasWalkedThroughChanged(
    AuthenticationHasWalkedThroughChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    return emit(
      state.copyWith(
        hasWalkedThrough: event.hasWalkedThrough,
      ),
    );
  }

  void _onAuthenticationSignInAnonymous(
    AuthenticationSignInAnonymous event,
    Emitter<AuthenticationState> emit,
  ) async {
    return emit(
      state.copyWith(
        isSignedInAnonymous: true,
      ),
    );
  }

  void _onAuthenticationChanged(
    AuthenticationChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    return emit(
      state.copyWith(
        authenticated: event.authenticated,
      ),
    );
  }

  void _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    return emit(
      state.copyWith(
        checker: !state.checker,
      ),
    );
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(
      authenticated: false,
      isSignedInAnonymous: false,
    ));
  }

  void _onAuthenticationChecker(
    AuthenticationChecker event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(
      state.copyWith(checker: event.check),
    );
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    return AuthenticationState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toMap();
  }
}
