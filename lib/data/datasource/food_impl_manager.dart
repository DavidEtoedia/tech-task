import 'package:flutter_tech_task_master/data/datasource/food_data_source.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_tech_task_master/domain/repository/food_repository.dart';

class FoodImplManager implements FoodRepository {
  final FoodService _foodService;
  FoodImplManager(this._foodService);

  @override
  Future<List<Ingredients>> getAllIngredients() async =>
      _foodService.ingredients();

  @override
  Future<List<RecipeModel>> getAllRecipe(
          String ingredientA, String ingredientB) async =>
      _foodService.recipes(ingredientA, ingredientB);
}
