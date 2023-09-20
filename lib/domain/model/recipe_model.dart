import 'dart:convert';

List<RecipeModel> recipeModelFromJson(String str) => List<RecipeModel>.from(
    json.decode(str).map((x) => RecipeModel.fromJson(x)));

class RecipeModel {
  String? title;
  List<String>? ingredients;

  RecipeModel({
    this.title,
    this.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        title: json["title"],
        ingredients: json["ingredients"] == null
            ? []
            : List<String>.from(json["ingredients"]!.map((x) => x)),
      );
}
