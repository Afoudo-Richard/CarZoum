part of 'seller_info_bloc.dart';

@immutable
abstract class SellerInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SellerInfoVehiclesFetched extends SellerInfoEvent {
  final bool refresh;
  SellerInfoVehiclesFetched({this.refresh = false});
}
