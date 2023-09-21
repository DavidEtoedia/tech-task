// ignore_for_file: prefer_const_constructors
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IngredientEvent', () {
    group('Select Ingredient Event', () {
      test('supports value comparisons', () {
        expect(SelectDateEvent.datePressed(data: "data"),
            SelectDateEvent.datePressed(data: "data"));
      });
    });
  });
}
