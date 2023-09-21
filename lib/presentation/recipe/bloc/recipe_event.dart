part of 'recipe_bloc.dart';

class RecipeEvent extends Equatable {
  const RecipeEvent();

  factory RecipeEvent.started() => const _Started();

  factory RecipeEvent.getRecipe({
    required String ingredentA,
    required String ingredentB,
  }) {
    return _GetRecipe(ingredentA: ingredentA, ingredentB: ingredentB);
  }

  @override
  List<Object?> get props => [];
}

class _Started extends RecipeEvent {
  const _Started();
}

class _GetRecipe extends RecipeEvent {
  final String ingredentA;
  final String ingredentB;

  const _GetRecipe({
    required this.ingredentA,
    required this.ingredentB,
  });

  @override
  List<Object?> get props => [ingredentA, ingredentB];
}
