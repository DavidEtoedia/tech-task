import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IngredientState', () {
    test('supports value comparisons', () {
      expect(IngredientState.initial(), IngredientState.initial());
    });

    test('returns same object at app launch', () {
      expect(IngredientState.initial().copyWith(), IngredientState.initial());
    });

    test('returns object with updated status when status is successfully', () {
      expect(
        IngredientState.initial().copyWith(status: Status.success),
        IngredientState.initial().copyWith(status: Status.success),
      );
    });
  });
}
