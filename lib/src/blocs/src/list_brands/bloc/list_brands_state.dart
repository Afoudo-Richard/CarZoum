// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_brands_bloc.dart';

enum ListBrandsStatus { initial, success, failure, refresh }

class ListBrandsState extends Equatable {
  final List<Brand> brands;
  final List<Brand> brandsCopy;
  final Brand? selectedBrand;
  final ListBrandsStatus listBrandsStatus;
  final bool hasReachedMax;

  const ListBrandsState({
    this.brands = const <Brand>[],
    this.brandsCopy = const <Brand>[],
    this.selectedBrand,
    this.listBrandsStatus = ListBrandsStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props =>
      [brands, brandsCopy, selectedBrand, listBrandsStatus, hasReachedMax];

  ListBrandsState copyWith({
    List<Brand>? brands,
    List<Brand>? brandsCopy,
    Brand? selectedBrand,
    ListBrandsStatus? listBrandsStatus,
    bool? hasReachedMax,
  }) {
    return ListBrandsState(
      brands: brands ?? this.brands,
      brandsCopy: brandsCopy ?? this.brandsCopy,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      listBrandsStatus: listBrandsStatus ?? this.listBrandsStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brands': brands.map((x) => x.toMap()).toList(),
      'brandsCopy': brandsCopy.map((x) => x.toMap()).toList(),
      'listBrandsStatus': listBrandsStatus.name,
      'hasReachedMax': hasReachedMax,
    };
  }

  factory ListBrandsState.fromMap(Map<String, dynamic> map) {
    return ListBrandsState(
      brands: List<Brand>.from(
        (map['brands'] as List<dynamic>).map<Brand>(
          (x) => Brand.fromMap(x as Map<String, dynamic>),
        ),
      ),
      brandsCopy: List<Brand>.from(
        (map['brandsCopy'] as List<dynamic>).map<Brand>(
          (x) => Brand.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listBrandsStatus:
          ListBrandsStatus.values.byName(map['listBrandsStatus'] as String),
      hasReachedMax: map['hasReachedMax'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListBrandsState.fromJson(String source) =>
      ListBrandsState.fromMap(json.decode(source) as Map<String, dynamic>);
}
