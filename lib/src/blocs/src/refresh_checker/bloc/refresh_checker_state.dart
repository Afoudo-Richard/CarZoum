part of 'refresh_checker_bloc.dart';

enum RefreshCheckerStatus { initial, success, failure, refresh }

class RefreshCheckerState extends Equatable {
  final int brandChangeCount;
  final int modelChangeCount;
  final int conditionTypeChangeCount;
  final int fuelTypeChangeCount;
  final int transmissionTypeCount;
  final RefreshCheckerStatus refreshCheckerStatus;

  const RefreshCheckerState({
    this.brandChangeCount = 0,
    this.modelChangeCount = 0,
    this.conditionTypeChangeCount = 0,
    this.fuelTypeChangeCount = 0,
    this.transmissionTypeCount = 0,
    this.refreshCheckerStatus = RefreshCheckerStatus.initial,
  });

  @override
  List<Object> get props {
    return [
      brandChangeCount,
      modelChangeCount,
      conditionTypeChangeCount,
      fuelTypeChangeCount,
      transmissionTypeCount,
      refreshCheckerStatus,
    ];
  }

  RefreshCheckerState copyWith({
    int? brandChangeCount,
    int? modelChangeCount,
    int? conditionTypeChangeCount,
    int? fuelTypeChangeCount,
    int? transmissionTypeCount,
    RefreshCheckerStatus? refreshCheckerStatus,
  }) {
    return RefreshCheckerState(
      brandChangeCount: brandChangeCount ?? this.brandChangeCount,
      modelChangeCount: modelChangeCount ?? this.modelChangeCount,
      conditionTypeChangeCount:
          conditionTypeChangeCount ?? this.conditionTypeChangeCount,
      fuelTypeChangeCount: fuelTypeChangeCount ?? this.fuelTypeChangeCount,
      transmissionTypeCount:
          transmissionTypeCount ?? this.transmissionTypeCount,
      refreshCheckerStatus: refreshCheckerStatus ?? this.refreshCheckerStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brandChangeCount': brandChangeCount,
      'modelChangeCount': modelChangeCount,
      'conditionTypeChangeCount': conditionTypeChangeCount,
      'fuelTypeChangeCount': fuelTypeChangeCount,
      'transmissionTypeCount': transmissionTypeCount,
      'refreshCheckerStatus': refreshCheckerStatus.name,
    };
  }

  factory RefreshCheckerState.fromMap(Map<String, dynamic> map) {
    return RefreshCheckerState(
      brandChangeCount: map['brandChangeCount'] as int,
      modelChangeCount: map['modelChangeCount'] as int,
      conditionTypeChangeCount: map['conditionTypeChangeCount'] as int,
      fuelTypeChangeCount: map['fuelTypeChangeCount'] as int,
      transmissionTypeCount: map['transmissionTypeCount'] as int,
      refreshCheckerStatus: RefreshCheckerStatus.values
          .byName(map['refreshCheckerStatus'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshCheckerState.fromJson(String source) =>
      RefreshCheckerState.fromMap(json.decode(source) as Map<String, dynamic>);
}
