part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  final List<RecipeModel> result;
  final String? errorMessage;
  final bool isLoading;

  const RecipeState({
    this.errorMessage,
    required this.result,
    required this.isLoading,
  });

  factory RecipeState.initial() {
    return const RecipeState(
      result: [],
      errorMessage: '',
      isLoading: false,
    );
  }

  RecipeState copyWith(
      {String? errorMessage, bool? isLoading, List<RecipeModel>? result}) {
    return RecipeState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''RecipeState {result: ${result.length}, loading: $isLoading }''';
  }

  @override
  List<Object?> get props => [result, errorMessage, isLoading];
}
