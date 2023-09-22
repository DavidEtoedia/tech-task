import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late MockFoodUseCase mockFoodUsecase;

  setUp(() {
    mockFoodUsecase = MockFoodUseCase();
  });

  test("Ingredient usecase", () async {
    when(() => mockFoodUsecase.fetchIngredients())
        .thenAnswer((_) async => [const Ingredients(title: "", useby: "")]);
    final res = await mockFoodUsecase.fetchIngredients();
    expect(res, isA<List<Ingredients>>());
  });

  test("Recipe usecase", () async {
    when(() => mockFoodUsecase.fetchRecipes("IngredientA", "IngredientB"))
        .thenAnswer((_) async => [const RecipeModel()]);
    final res =
        await mockFoodUsecase.fetchRecipes("IngredientA", "IngredientB");
    expect(res, isA<List<RecipeModel>>());
  });
}
