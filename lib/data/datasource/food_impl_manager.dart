import 'package:flutter_tech_task_master/data/datasource/food_data_source.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';

class FoodImplManager {
  final FoodService _foodService;
  FoodImplManager(this._foodService);

  Future<List<Ingredients>> fetchIngredients() async =>
      _foodService.ingredients();

  Future<List<RecipeModel>> fetchRecipe(
          String ingredientA, String ingredientB) async =>
      _foodService.recipes(ingredientA, ingredientB);
}
