import 'package:flutter_tech_task_master/core/constants/app_url.dart';
import 'package:flutter_tech_task_master/core/service/http_service.dart';
import 'package:flutter_tech_task_master/core/service/network_service.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';

class FoodService {
  final NetworkService _httpService;
  FoodService({required NetworkService httpService})
      : _httpService = httpService;

  Future<List<Ingredients>> ingredients() async {
    try {
      const url = AppUrl.ingredient;
      final response = await _httpService.request(url, RequestMethod.get);
      return List<Ingredients>.from(
          response.data.map((x) => Ingredients.fromJson(x)));
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<RecipeModel>> recipes(
      String ingredientA, String ingredientB) async {
    try {
      const url = AppUrl.recipe;
      final response = await _httpService.request(url, RequestMethod.get,
          queryParams: {"ingredient": "$ingredientA,$ingredientB"});
      return List<RecipeModel>.from(
          response.data.map((x) => RecipeModel.fromJson(x)));
    } catch (e) {
      throw e.toString();
    }
  }
}
