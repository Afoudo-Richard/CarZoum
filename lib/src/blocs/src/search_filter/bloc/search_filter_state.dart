// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_filter_bloc.dart';

enum SearchFilterStatus { initial, success, failure, refresh }

class SearchFilterState extends Equatable {
  final Brand? brand;
  final Model? model;

  final FuelType? fuelType;
  final ConditionType? conditionType;
  final TransmissionType? transmissionType;
  final bool? isRegistered;
  final bool? isNegotiable;
  final int startYearOfManufacture;
  int endYearOfManufacture;
  final int initialStartYearOfManufacuture;
  final int initialEndYearOfManufacture;
  final int startPrice;
  final int endPrice;
  final int intialStartPrice;
  final int intialEndPrice;
  final int startMileage;
  final int endMileage;
  final int initialStartMileage;
  final int initialEndMileage;
  final String? errorMessage;
  final List<Vehicle> vehicles;
  final SearchFilterStatus searchFilterStatus;
  final bool hasReachedMax;

  SearchFilterState({
    this.brand,
    this.model,
    this.fuelType,
    this.conditionType,
    this.transmissionType,
    this.isRegistered,
    this.isNegotiable,
    this.startYearOfManufacture = 1884,
    // this.endYearOfManufacture = 0,
    this.initialStartYearOfManufacuture = 1884,
    // this.initialEndYearOfManufacture = 0,
    this.intialStartPrice = 0,
    this.intialEndPrice = 0,
    this.initialStartMileage = 0,
    this.initialEndMileage = 500000,
    this.startPrice = 0,
    this.endPrice = 0,
    this.startMileage = 0,
    this.endMileage = 500000,
    this.errorMessage,
    this.vehicles = const [],
    this.searchFilterStatus = SearchFilterStatus.initial,
    this.hasReachedMax = false,
  })  : initialEndYearOfManufacture = DateTime.now().year,
        endYearOfManufacture = DateTime.now().year;

  @override
  List<Object?> get props {
    return [
      brand,
      model,
      fuelType,
      conditionType,
      transmissionType,
      isRegistered,
      isNegotiable,
      startYearOfManufacture,
      endYearOfManufacture,
      initialStartYearOfManufacuture,
      initialEndYearOfManufacture,
      startPrice,
      endPrice,
      intialStartPrice,
      intialEndPrice,
      startMileage,
      endMileage,
      initialStartMileage,
      initialEndMileage,
      errorMessage,
      vehicles,
      searchFilterStatus,
      hasReachedMax,
    ];
  }

  SearchFilterState copyWith({
    Brand? brand,
    Model? model,
    int? yearOfManufacture,
    FuelType? fuelType,
    ConditionType? conditionType,
    TransmissionType? transmissionType,
    bool? isRegistered,
    bool? isNegotiable,
    int? startYearOfManufacture,
    int? endYearOfManufacture,
    int? initialStartYearOfManufacuture,
    int? initialEndYearOfManufacture,
    int? startPrice,
    int? endPrice,
    int? intialStartPrice,
    int? intialEndPrice,
    int? startMileage,
    int? endMileage,
    int? initialStartMileage,
    int? initialEndMileage,
    String? errorMessage,
    List<Vehicle>? vehicles,
    SearchFilterStatus? searchFilterStatus,
    bool? hasReachedMax,
  }) {
    return SearchFilterState(
      brand: brand,
      model: model,
      fuelType: fuelType,
      conditionType: conditionType,
      transmissionType: transmissionType,
      isRegistered: isRegistered ?? this.isRegistered,
      isNegotiable: isNegotiable ?? this.isNegotiable,
      startYearOfManufacture:
          startYearOfManufacture ?? this.startYearOfManufacture,
      // endYearOfManufacture: endYearOfManufacture ?? this.endYearOfManufacture,
      initialStartYearOfManufacuture:
          initialStartYearOfManufacuture ?? this.initialStartYearOfManufacuture,
      startPrice: startPrice ?? this.startPrice,
      endPrice: endPrice ?? this.endPrice,
      intialStartPrice: intialStartPrice ?? this.intialStartPrice,
      intialEndPrice: intialEndPrice ?? this.intialEndPrice,
      startMileage: startMileage ?? this.startMileage,
      endMileage: endMileage ?? this.endMileage,
      initialStartMileage: initialStartMileage ?? this.initialStartMileage,
      initialEndMileage: initialEndMileage ?? this.initialEndMileage,
      errorMessage: errorMessage ?? this.errorMessage,
      vehicles: vehicles ?? this.vehicles,
      searchFilterStatus: searchFilterStatus ?? this.searchFilterStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    )..endYearOfManufacture = endYearOfManufacture ?? this.endYearOfManufacture;
  }
}
