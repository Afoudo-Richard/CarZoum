// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'store_details_bloc.dart';

enum StoreDetailsLogoStatus { initial, loading, success, failure }

class StoreDetailsState extends Equatable {
  final StoreName storeName;
  final StoreLocation storeLocation;
  final StoreAbout storeAbout;
  final FormzStatus formStatus;
  final StoreDetailsLogoStatus storeDetailsLogoStatus;

  StoreDetailsState({
    this.storeName = const StoreName.pure(),
    this.storeLocation = const StoreLocation.pure(),
    this.storeAbout = const StoreAbout.pure(),
    this.formStatus = FormzStatus.pure,
    this.storeDetailsLogoStatus = StoreDetailsLogoStatus.initial,
  });

  @override
  List<Object> get props => [
        storeName,
        storeLocation,
        storeAbout,
        formStatus,
        storeDetailsLogoStatus,
      ];

  StoreDetailsState copyWith({
    StoreName? storeName,
    StoreLocation? storeLocation,
    StoreAbout? storeAbout,
    FormzStatus? formStatus,
    StoreDetailsLogoStatus? storeDetailsLogoStatus,
  }) {
    return StoreDetailsState(
      storeName: storeName ?? this.storeName,
      storeLocation: storeLocation ?? this.storeLocation,
      storeAbout: storeAbout ?? this.storeAbout,
      formStatus: formStatus ?? this.formStatus,
      storeDetailsLogoStatus:
          storeDetailsLogoStatus ?? this.storeDetailsLogoStatus,
    );
  }
}
