// ignore_for_file: prefer_const_constructors
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RecipeEvent', () {
    group('Create Recipe Event', () {
      test('supports value comparisons', () {
        expect(
            RecipeEvent.getRecipe(
                ingredentA: "ingredentA", ingredentB: "ingredentB"),
            RecipeEvent.getRecipe(
                ingredentA: "ingredentA", ingredentB: "ingredentB"));
      });
    });
  });
}
