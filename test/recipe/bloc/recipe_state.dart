import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RecipeState', () {
    test('supports value comparisons', () {
      expect(RecipeState.initial(), RecipeState.initial());
    });

    test('returns list of recipes successfully', () {
      expect(
        RecipeState.initial().copyWith(result: [const RecipeModel()]),
        RecipeState.initial().copyWith(result: [const RecipeModel()]),
      );
    });
  });
}
