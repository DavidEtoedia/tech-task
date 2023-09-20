import 'dart:convert';

List<Ingredients> ingredientsFromJson(String str) => List<Ingredients>.from(
    json.decode(str).map((x) => Ingredients.fromJson(x)));

class Ingredients {
  String? title;
  String? useby;

  Ingredients({this.title, this.useby});

  factory Ingredients.fromJson(Map<String, dynamic> json) =>
      Ingredients(title: json["title"], useby: json['use-by']);
}
