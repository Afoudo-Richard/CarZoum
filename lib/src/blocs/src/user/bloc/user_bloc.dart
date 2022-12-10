import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:carzoum/carzoum.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserChanged>(_onUserChanged);
    on<UserLanguangeChanged>(_onUserLanguangeChanged);
  }

  void _onUserChanged(
    UserChanged event,
    Emitter<UserState> emit,
  ) async {
    return emit(
      state.copyWith(
        user: event.user,
        checker: !state.checker,
      ),
    );
  }

  void _onUserLanguangeChanged(
    UserLanguangeChanged event,
    Emitter<UserState> emit,
  ) async {
    return emit(
      state.copyWith(
        locale: event.locale,
      ),
    );
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toMap();
  }
}
