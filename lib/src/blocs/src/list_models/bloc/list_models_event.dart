part of 'list_models_bloc.dart';

@immutable
abstract class ListModelsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ModelsFetched extends ListModelsEvent {
  final bool refresh;
  ModelsFetched({this.refresh = false});
}

class SearchModelChanged extends ListModelsEvent {
  final String text;
  final Brand? brand;
  SearchModelChanged({required this.text, this.brand});
}
