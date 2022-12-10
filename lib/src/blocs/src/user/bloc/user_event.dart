part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserChanged extends UserEvent {
  const UserChanged({
    required this.user,
  });
  final User? user;

  @override
  List<Object?> get props => [user];
}

class UserLanguangeChanged extends UserEvent {
  final Locale locale;
  const UserLanguangeChanged({
    required this.locale,
  });
  @override
  List<Object?> get props => [locale];
}
