import 'package:flutter_tech_task_master/data/datasource/food_impl_manager.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_tech_task_master/domain/repository/food_repository.dart';

class FoodUseCase implements FoodRepository {
  final FoodImplManager _foodImplManager;
  FoodUseCase({required FoodImplManager foodImplManager})
      : _foodImplManager = foodImplManager;

  @override
  Future<List<Ingredients>> getAllIngredients() async =>
      await _foodImplManager.fetchIngredients();

  @override
  Future<List<RecipeModel>> getAllRecipe(
          String ingredientA, String ingredientB) async =>
      await _foodImplManager.fetchRecipe(ingredientA, ingredientB);
}
