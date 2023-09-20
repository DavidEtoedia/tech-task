import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';

abstract class FoodRepository {
  Future<List<Ingredients>> getAllIngredients();
  Future<List<RecipeModel>> getAllRecipe(
      String ingredientA, String ingredientB);
}
