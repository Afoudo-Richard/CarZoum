part of 'refresh_checker_bloc.dart';

@immutable
abstract class RefreshCheckerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RefreshChecked extends RefreshCheckerEvent {}
