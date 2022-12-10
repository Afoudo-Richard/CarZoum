part of 'list_condition_types_bloc.dart';

abstract class ListConditionTypesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConditionTypesFetched extends ListConditionTypesEvent {
  final bool refresh;
  ConditionTypesFetched({this.refresh = false});
}
