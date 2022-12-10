// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_models_bloc.dart';

enum ListModelsStatus { initial, success, failure, refresh }

class ListModelsState extends Equatable {
  final List<Model> models;
  final List<Model> modelsCopy;
  final Model? selectedModel;
  final ListModelsStatus listModelsStatus;
  final bool hasReachedMax;

  const ListModelsState({
    this.models = const <Model>[],
    this.modelsCopy = const <Model>[],
    this.selectedModel,
    this.listModelsStatus = ListModelsStatus.initial,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [
        models,
        modelsCopy,
        selectedModel,
        listModelsStatus,
        hasReachedMax,
      ];

  ListModelsState copyWith({
    List<Model>? models,
    List<Model>? modelsCopy,
    Model? selectedModel,
    ListModelsStatus? listModelsStatus,
    bool? hasReachedMax,
  }) {
    return ListModelsState(
      models: models ?? this.models,
      modelsCopy: modelsCopy ?? this.modelsCopy,
      selectedModel: selectedModel ?? this.selectedModel,
      listModelsStatus: listModelsStatus ?? this.listModelsStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'models': models.map((x) => x.toMap()).toList(),
      'modelsCopy': modelsCopy.map((x) => x.toMap()).toList(),
      'listModelsStatus': listModelsStatus.name,
      'hasReachedMax': hasReachedMax,
    };
  }

  factory ListModelsState.fromMap(Map<String, dynamic> map) {
    return ListModelsState(
      models: List<Model>.from(
        (map['models'] as List<dynamic>).map<Model>(
          (x) => Model.fromMap(x as Map<String, dynamic>),
        ),
      ),
      modelsCopy: List<Model>.from(
        (map['modelsCopy'] as List<dynamic>).map<Model>(
          (x) => Model.fromMap(x as Map<String, dynamic>),
        ),
      ),
      listModelsStatus:
          ListModelsStatus.values.byName(map['listModelsStatus'] as String),
      hasReachedMax: map['hasReachedMax'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListModelsState.fromJson(String source) =>
      ListModelsState.fromMap(json.decode(source) as Map<String, dynamic>);
}
