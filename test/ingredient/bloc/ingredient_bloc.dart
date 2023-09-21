import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late FoodUseCase foodUseCase;
  late IngredientsBloc ingredientBloc;

  setUp(() {
    foodUseCase = MockFoodUseCase();
    ingredientBloc = IngredientsBloc(foodUseCase);
  });

  group('IngredientBloc', () {
    test('initial state is IngredientState.initial', () {
      expect(ingredientBloc.state, IngredientState.initial());
    });
    group('Ingredient', () {
      blocTest<IngredientsBloc, IngredientState>(
        'emits [IngredientState is loading, IngredientState success] '
        'when app at start up succeeds',
        setUp: () {
          when(
            () => foodUseCase.getAllIngredients(),
          ).thenAnswer((_) => Future<List<Ingredients>>.value(
              [const Ingredients(title: "A", useby: "B")]));
        },
        build: () => ingredientBloc,
        act: (bloc) => bloc.add(const SelectDateEvent()),
        expect: () => <IngredientState>[
          const IngredientState(
            result: [],
            status: Status.initial,
            search: [],
            isLoading: true,
          ),
          const IngredientState(
            result: [Ingredients(title: "A", useby: "B")],
            status: Status.success,
            search: [Ingredients(title: "A", useby: "B")],
            isLoading: false,
          )
        ],
      );

      blocTest<IngredientsBloc, IngredientState>(
        'emits IngredientState is loading, IngredientState success '
        'when a date is selected',
        setUp: () {
          when(
            () => foodUseCase.getAllIngredients(),
          ).thenAnswer((_) => Future<List<Ingredients>>.value(
              [const Ingredients(title: "Ham", useby: "2012-2-12")]));
        },
        build: () => ingredientBloc,
        act: (bloc) => bloc
          ..add(const SelectDateEvent())
          ..add(SelectDateEvent.datePressed(data: "2012-2-12")),
        expect: () => <IngredientState>[
          const IngredientState(
            result: [],
            status: Status.initial,
            search: [],
            isLoading: true,
          ),
          const IngredientState(
            result: [Ingredients(title: "Ham", useby: "2012-2-12")],
            status: Status.success,
            search: [Ingredients(title: "Ham", useby: "2012-2-12")],
            isLoading: false,
          ),
        ],
      );
    });
  });
}
