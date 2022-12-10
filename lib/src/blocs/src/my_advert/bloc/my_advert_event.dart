part of 'my_advert_bloc.dart';

@immutable
abstract class MyAdvertEvent extends Equatable {
  const MyAdvertEvent();

  @override
  List<Object> get props => [];
}

class MyAdvertStatusChanged extends MyAdvertEvent {
  final AdvertStatus advertStatus;

  const MyAdvertStatusChanged({required this.advertStatus});
}

class MyAdvertsCategoryFetched extends MyAdvertEvent {
  final bool refresh;
  const MyAdvertsCategoryFetched({this.refresh = false});
}

class MyAdvertsActiveCountFetched extends MyAdvertEvent {}

class MyAdvertsDeclinedCountFetched extends MyAdvertEvent {}

class MyAdvertsReviewingCountFetched extends MyAdvertEvent {}

class MyAdvertsClosedCountFetched extends MyAdvertEvent {}

class MyAdvertsAllCountFetched extends MyAdvertEvent {}

class MyAdvertsChangeStatus extends MyAdvertEvent {
  final AdvertsVerificationStatus advertsVerificationStatus;
  final Vehicle vehicle;

  const MyAdvertsChangeStatus({
    required this.advertsVerificationStatus,
    required this.vehicle,
  });
}
