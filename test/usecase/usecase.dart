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

  test("Ingredient service", () async {
    when(() => mockFoodUsecase.getAllIngredients())
        .thenAnswer((_) async => [const Ingredients()]);
    final res = await mockFoodUsecase.getAllIngredients();
    expect(res, isA<List<Ingredients>>());
  });

  test("Recipe service", () async {
    when(() => mockFoodUsecase.getAllRecipe("IngredientA", "IngredientB"))
        .thenAnswer((_) async => [const RecipeModel()]);
    final res =
        await mockFoodUsecase.getAllRecipe("IngredientA", "IngredientB");
    expect(res, isA<List<RecipeModel>>());
  });

  // test("Recipe service", () async {
  //   final response = MockDioResponse();
  //   when(() => response.statusCode).thenReturn(200);
  //   when(() => response.data).thenReturn(
  //     MockResponse.ingredient,
  //   );

  //   when(() => mockFoodUsecase.getAllIngredients())
  //       .thenAnswer((_) async => [const Ingredients()]);

  //   final res = await mockFoodUsecase.getAllIngredients();
  //   expect(res, isA<List<Ingredients>>());
  // });

  // test("Recipe service", () async {
  //   final response = MockDioResponse();
  //   when(() => response.statusCode).thenReturn(200);
  //   when(() => response.data).thenReturn(
  //     MockResponse.recipe,
  //   );

  //   when(() => mockService.recipes("IngredientA", "IngredientB")).thenAnswer(
  //       (_) async => Future.value(List<RecipeModel>.from(
  //           response.data.map((x) => RecipeModel.fromJson(x)))));

  //   final res = await mockService.ingredients();
  //   expect(res, isA<List<Ingredients>>());
  // });
}
