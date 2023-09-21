import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/mocks.dart';
import '../mocks/mocks_response.dart';

void main() {
  late MockService mockService;

  setUp(() {
    mockService = MockService();
  });

  test("Ingredient service", () async {
    final response = MockDioResponse();
    when(() => response.statusCode).thenReturn(200);
    when(() => response.data).thenReturn(
      MockResponse.ingredient,
    );

    when(() => mockService.ingredients()).thenAnswer((_) async => Future.value(
        List<Ingredients>.from(
            response.data.map((x) => Ingredients.fromJson(x)))));

    final res = await mockService.ingredients();
    expect(res, isA<List<Ingredients>>());
  });

  test("Recipe service", () async {
    final response = MockDioResponse();
    when(() => response.statusCode).thenReturn(200);
    when(() => response.data).thenReturn(
      MockResponse.recipe,
    );

    when(() => mockService.recipes("IngredientA", "IngredientB")).thenAnswer(
        (_) async => Future.value(List<RecipeModel>.from(
            response.data.map((x) => RecipeModel.fromJson(x)))));

    final res = await mockService.ingredients();
    expect(res, isA<List<Ingredients>>());
  });
}
