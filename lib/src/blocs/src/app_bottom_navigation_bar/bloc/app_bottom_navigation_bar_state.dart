part of 'app_bottom_navigation_bar_bloc.dart';

class AppBottomNavigationBarState extends Equatable {
  final Widget activePage;
  AppBottomNavigationBarState({
    this.activePage = const HomePage(),
  });

  @override
  List<Object> get props => [activePage];

  AppBottomNavigationBarState copyWith({
    Widget? activePage,
  }) {
    return AppBottomNavigationBarState(
      activePage: activePage ?? this.activePage,
    );
  }
}
