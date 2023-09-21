import 'dart:convert';

import 'package:equatable/equatable.dart';

List<RecipeModel> recipeModelFromJson(String str) => List<RecipeModel>.from(
    json.decode(str).map((x) => RecipeModel.fromJson(x)));

class RecipeModel extends Equatable {
  final String? title;
  final List<String>? ingredients;

  const RecipeModel({
    this.title,
    this.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        title: json["title"],
        ingredients: json["ingredients"] == null
            ? []
            : List<String>.from(json["ingredients"]!.map((x) => x)),
      );

  @override
  List<Object?> get props => [title, ingredients];
}
