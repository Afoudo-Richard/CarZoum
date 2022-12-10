part of 'list_condition_types_bloc.dart';

enum ListConditionTypesStatus { initial, success, failure, refresh }

class ListConditionTypesState extends Equatable {
  final List<ConditionType> conditionTypes;
  final ListConditionTypesStatus listConditionTypesStatus;
  final bool hasReachedMax;

  const ListConditionTypesState({
    this.conditionTypes = const [],
    this.listConditionTypesStatus = ListConditionTypesStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [
        conditionTypes,
        listConditionTypesStatus,
        hasReachedMax,
      ];

  ListConditionTypesState copyWith({
    List<ConditionType>? conditionTypes,
    ListConditionTypesStatus? listConditionTypesStatus,
    bool? hasReachedMax,
  }) {
    return ListConditionTypesState(
      conditionTypes: conditionTypes ?? this.conditionTypes,
      listConditionTypesStatus:
          listConditionTypesStatus ?? this.listConditionTypesStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conditionTypes': conditionTypes.map((x) => x.toMap()).toList(),
      'listConditionTypesStatus': listConditionTypesStatus.name,
      'hasReachedMax': hasReachedMax,
    };
  }

  factory ListConditionTypesState.fromMap(Map<String, dynamic> map) {
    return ListConditionTypesState(
      conditionTypes: List<ConditionType>.from(
        (map['conditionTypes'] as List<dynamic>).map<ConditionType>(
          (x) => ConditionType.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listConditionTypesStatus: ListConditionTypesStatus.values
          .byName(map['listConditionTypesStatus'] as String),
      hasReachedMax: map['hasReachedMax'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListConditionTypesState.fromJson(String source) =>
      ListConditionTypesState.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
