import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_tech_task_master/domain/repository/food_repository.dart';

class FoodUseCase {
  final FoodRepository _foodRepository;
  FoodUseCase({required FoodRepository foodRepository})
      : _foodRepository = foodRepository;

  Future<List<Ingredients>> fetchIngredients() async =>
      await _foodRepository.getAllIngredients();

  Future<List<RecipeModel>> fetchRecipes(
          String ingredientA, String ingredientB) async =>
      await _foodRepository.getAllRecipe(ingredientA, ingredientB);
}
