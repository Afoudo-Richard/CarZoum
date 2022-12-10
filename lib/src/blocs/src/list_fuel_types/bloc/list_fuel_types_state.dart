// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_fuel_types_bloc.dart';

enum ListFuelTypesStatus { initial, success, failure, refresh }

class ListFuelTypesState extends Equatable {
  final List<FuelType> fuelTypes;
  final ListFuelTypesStatus listFuelTypesStatus;
  final bool hasReachedMax;

  const ListFuelTypesState({
    this.fuelTypes = const [],
    this.listFuelTypesStatus = ListFuelTypesStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [
        fuelTypes,
        listFuelTypesStatus,
        hasReachedMax,
      ];

  ListFuelTypesState copyWith({
    List<FuelType>? fuelTypes,
    ListFuelTypesStatus? listFuelTypesStatus,
    bool? hasReachedMax,
  }) {
    return ListFuelTypesState(
      fuelTypes: fuelTypes ?? this.fuelTypes,
      listFuelTypesStatus: listFuelTypesStatus ?? this.listFuelTypesStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fuelTypes': fuelTypes.map((x) => x.toMap()).toList(),
      'listFuelTypesStatus': listFuelTypesStatus.name,
      'hasReachedMax': hasReachedMax,
    };
  }

  factory ListFuelTypesState.fromMap(Map<String, dynamic> map) {
    return ListFuelTypesState(
      fuelTypes: List<FuelType>.from(
        (map['fuelTypes'] as List<dynamic>).map<FuelType>(
          (x) => FuelType.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listFuelTypesStatus: ListFuelTypesStatus.values
          .byName(map['listFuelTypesStatus'] as String),
      hasReachedMax: map['hasReachedMax'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListFuelTypesState.fromJson(String source) =>
      ListFuelTypesState.fromMap(json.decode(source) as Map<String, dynamic>);
}
