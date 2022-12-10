part of 'list_transmission_types_bloc.dart';

enum ListTransmissionTypesStatus { initial, success, failure, refresh }

class ListTransmissionTypesState extends Equatable {
  final List<TransmissionType> transmissionTypes;
  final ListTransmissionTypesStatus listTransmissionTypesStatus;
  final bool hasReachedMax;

  const ListTransmissionTypesState({
    this.transmissionTypes = const [],
    this.listTransmissionTypesStatus = ListTransmissionTypesStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [
        transmissionTypes,
        listTransmissionTypesStatus,
        hasReachedMax,
      ];

  ListTransmissionTypesState copyWith({
    List<TransmissionType>? transmissionTypes,
    ListTransmissionTypesStatus? listTransmissionTypesStatus,
    bool? hasReachedMax,
  }) {
    return ListTransmissionTypesState(
      transmissionTypes: transmissionTypes ?? this.transmissionTypes,
      listTransmissionTypesStatus:
          listTransmissionTypesStatus ?? this.listTransmissionTypesStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transmissionTypes': transmissionTypes.map((x) => x.toMap()).toList(),
      'listTransmissionTypesStatus': listTransmissionTypesStatus.name,
      'hasReachedMax': hasReachedMax,
    };
  }

  factory ListTransmissionTypesState.fromMap(Map<String, dynamic> map) {
    return ListTransmissionTypesState(
      transmissionTypes: List<TransmissionType>.from(
        (map['transmissionTypes'] as List<dynamic>).map<TransmissionType>(
          (x) => TransmissionType.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listTransmissionTypesStatus: ListTransmissionTypesStatus.values
          .byName(map['listTransmissionTypesStatus'] as String),
      hasReachedMax: map['hasReachedMax'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListTransmissionTypesState.fromJson(String source) =>
      ListTransmissionTypesState.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
