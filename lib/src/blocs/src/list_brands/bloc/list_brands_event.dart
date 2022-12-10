part of 'list_brands_bloc.dart';

@immutable
abstract class ListBrandsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BrandsFetched extends ListBrandsEvent {
  final bool refresh;
  BrandsFetched({this.refresh = false});
}

class BrandSelected extends ListBrandsEvent {
  final Brand brand;
  BrandSelected({required this.brand});
}

class SearchBrandChanged extends ListBrandsEvent {
  final String text;
  SearchBrandChanged({required this.text});
}
