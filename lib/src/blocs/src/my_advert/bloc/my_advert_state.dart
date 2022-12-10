// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'my_advert_bloc.dart';

enum MyAdvertFetchStatus { initial, success, failure, refresh }

enum AdvertsVerificationStatus { accept, decline }

enum AdvertAcceptStatus { intial, loading, success, failure }

enum AdvertDeclineStatus { intial, loading, success, failure }

class MyAdvertState extends Equatable {
  final AdvertStatus advertStatus;
  final List<Vehicle> vehicles;
  final MyAdvertFetchStatus myAdvertFetchStatus;
  final bool hasReachedMax;
  final int totalActiveVechicles;
  final int totalDeclinedVehicles;
  final int totalReviewingVehicles;
  final int totalClosedVehicles;
  final AdvertAcceptStatus advertAcceptStatus;
  final AdvertDeclineStatus advertDeclineStatus;
  final Vehicle? currentVehicle;

  MyAdvertState({
    this.advertStatus = AdvertStatus.active,
    this.vehicles = const [],
    this.myAdvertFetchStatus = MyAdvertFetchStatus.initial,
    this.hasReachedMax = false,
    this.totalActiveVechicles = 0,
    this.totalDeclinedVehicles = 0,
    this.totalReviewingVehicles = 0,
    this.totalClosedVehicles = 0,
    this.advertAcceptStatus = AdvertAcceptStatus.intial,
    this.advertDeclineStatus = AdvertDeclineStatus.intial,
    this.currentVehicle,
  });

  @override
  List<Object?> get props {
    return [
      advertStatus,
      vehicles,
      myAdvertFetchStatus,
      hasReachedMax,
      totalActiveVechicles,
      totalDeclinedVehicles,
      totalReviewingVehicles,
      totalClosedVehicles,
      advertAcceptStatus,
      advertDeclineStatus,
      currentVehicle,
    ];
  }

  MyAdvertState copyWith({
    AdvertStatus? advertStatus,
    List<Vehicle>? vehicles,
    MyAdvertFetchStatus? myAdvertFetchStatus,
    bool? hasReachedMax,
    int? totalActiveVechicles,
    int? totalDeclinedVehicles,
    int? totalReviewingVehicles,
    int? totalClosedVehicles,
    AdvertAcceptStatus? advertAcceptStatus,
    AdvertDeclineStatus? advertDeclineStatus,
    Vehicle? currentVehicle,
  }) {
    return MyAdvertState(
      advertStatus: advertStatus ?? this.advertStatus,
      vehicles: vehicles ?? this.vehicles,
      myAdvertFetchStatus: myAdvertFetchStatus ?? this.myAdvertFetchStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalActiveVechicles: totalActiveVechicles ?? this.totalActiveVechicles,
      totalDeclinedVehicles:
          totalDeclinedVehicles ?? this.totalDeclinedVehicles,
      totalReviewingVehicles:
          totalReviewingVehicles ?? this.totalReviewingVehicles,
      totalClosedVehicles: totalClosedVehicles ?? this.totalClosedVehicles,
      advertAcceptStatus: advertAcceptStatus ?? this.advertAcceptStatus,
      advertDeclineStatus: advertDeclineStatus ?? this.advertDeclineStatus,
      currentVehicle: currentVehicle ?? this.currentVehicle,
    );
  }
}
