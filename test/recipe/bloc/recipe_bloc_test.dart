import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late FoodUseCase foodUseCase;
  late RecipeBloc recipeBloc;

  setUp(() {
    foodUseCase = MockFoodUseCase();
    recipeBloc = RecipeBloc(foodUseCase);
  });

  group('RecipeBloc', () {
    test('initial state is RecipeState.initial', () {
      expect(recipeBloc.state, RecipeState.initial());
    });
    group('Recipe', () {
      blocTest<RecipeBloc, RecipeState>(
        'emits [RecipeState is loading, RecipeState success] '
        'when creating recipe',
        setUp: () {
          when(
            () => foodUseCase.fetchRecipes("ingredentA", "ingredentB"),
          ).thenAnswer(
              (_) => Future<List<RecipeModel>>.value([const RecipeModel()]));
        },
        build: () => recipeBloc,
        act: (bloc) => bloc.add(RecipeEvent.getRecipe(
            ingredentA: "ingredentA", ingredentB: "ingredentB")),
        expect: () => <RecipeState>[
          const RecipeState(
            result: [],
            isLoading: true,
          ),
          const RecipeState(result: [RecipeModel()], isLoading: false)
        ],
      );
    });
  });
}
