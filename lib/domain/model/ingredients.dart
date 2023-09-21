import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Ingredients> ingredientsFromJson(String str) => List<Ingredients>.from(
    json.decode(str).map((x) => Ingredients.fromJson(x)));

class Ingredients extends Equatable {
  final String? title;
  final String? useby;

  const Ingredients({this.title, this.useby});

  factory Ingredients.fromJson(Map<String, dynamic> json) =>
      Ingredients(title: json["title"], useby: json['use-by']);

  @override
  List<Object?> get props => [title, useby];

  @override
  bool get stringify => true; // Set this to true for better debug output
}
