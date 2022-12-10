// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_info_bloc.dart';

enum SellerInfoListVehiclesStatus { initial, success, failure, refresh }

class SellerInfoState extends Equatable {
  final List<Vehicle> vehicles;
  final SellerInfoListVehiclesStatus sellerInfoListVehiclesStatus;
  final bool hasReachedMax;

  SellerInfoState({
    this.vehicles = const <Vehicle>[],
    this.sellerInfoListVehiclesStatus = SellerInfoListVehiclesStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [
        vehicles,
        sellerInfoListVehiclesStatus,
        hasReachedMax,
      ];

  SellerInfoState copyWith({
    List<Vehicle>? vehicles,
    SellerInfoListVehiclesStatus? sellerInfoListVehiclesStatus,
    bool? hasReachedMax,
  }) {
    return SellerInfoState(
      vehicles: vehicles ?? this.vehicles,
      sellerInfoListVehiclesStatus:
          sellerInfoListVehiclesStatus ?? this.sellerInfoListVehiclesStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
