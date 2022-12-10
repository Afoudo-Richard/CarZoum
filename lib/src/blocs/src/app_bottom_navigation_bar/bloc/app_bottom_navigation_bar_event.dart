part of 'app_bottom_navigation_bar_bloc.dart';

@immutable
abstract class AppBottomNavigationBarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppBottomNavigationBarChanged extends AppBottomNavigationBarEvent {
  final Widget activePage;

  AppBottomNavigationBarChanged({required this.activePage});

  @override
  List<Object> get props => [activePage];
}
