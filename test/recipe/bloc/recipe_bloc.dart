import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../ingredient/bloc/ingredient_bloc.dart';

void main() {
  late FoodUseCase foodUseCase;
  late RecipeBloc recipeBloc;

  setUp(() {
    foodUseCase = MockFoodUse();
    recipeBloc = RecipeBloc(foodUseCase);
  });

  group('RecipeBloc', () {
    test('initial state is RecipeState.initial', () {
      expect(recipeBloc.state, RecipeState.initial());
    });
    group('Ingredient', () {
      blocTest<RecipeBloc, RecipeState>(
        'emits [RecipeState is loading, RecipeState success] '
        'when creating recipe',
        setUp: () {
          when(
            () => foodUseCase.getAllRecipe("ingredentA", "ingredentB"),
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

class kResponse {
  static var loginResponse = [
    {
      "title": "Ham and Cheese Toastie",
      "ingredients": ["Ham", "Cheese", "Bread", "Butter"]
    },
    {
      "title": "Salad",
      "ingredients": [
        "Lettuce",
        "Tomato",
        "Cucumber",
        "Beetroot",
        "Salad Dressing"
      ]
    },
    {
      "title": "Hotdog",
      "ingredients": ["Hotdog Bun", "Sausage", "Ketchup", "Mustard"]
    }
  ];
}
