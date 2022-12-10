part of 'list_transmission_types_bloc.dart';

abstract class ListTransmissionTypesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TransmissionTypesFetched extends ListTransmissionTypesEvent {
  final bool refresh;
  TransmissionTypesFetched({this.refresh = false});
}
