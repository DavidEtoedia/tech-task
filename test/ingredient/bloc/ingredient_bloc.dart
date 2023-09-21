import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFoodUse extends Mock implements FoodUseCase {}

void main() {
  late FoodUseCase foodUseCase;
  late IngredientsBloc ingredientBloc;

  setUp(() {
    foodUseCase = MockFoodUse();
    ingredientBloc = IngredientsBloc(foodUseCase);
  });

  group('IngredientBloc', () {
    test('initial state is IngredientState.initial', () {
      expect(ingredientBloc.state, IngredientState.initial());
    });
    group('Ingredient', () {
      // blocTest<IngredientsBloc, IngredientState>(
      //   'emits [IngredientState is loading, IngredientState success] '
      //   'when app at start up succeeds',
      //   setUp: () {
      //     when(
      //       () => foodUseCase.getAllIngredients(),
      //     ).thenAnswer(
      //         (_) => Future<List<Ingredients>>.value([const Ingredients()]));
      //   },
      //   build: () => ingredientBloc,
      //   act: (bloc) => bloc.add(const SelectDateEvent()),
      //   expect: () => <IngredientState>[
      //     const IngredientState(
      //         result: [],
      //         status: Status.initial,
      //         search: [],
      //         isLoading: true,
      //         errorMessage: ""),
      //     const IngredientState(
      //         result: [Ingredients()],
      //         status: Status.success,
      //         search: [Ingredients()],
      //         isLoading: false,
      //         errorMessage: "")
      //   ],
      // );

      blocTest<IngredientsBloc, IngredientState>(
        'emits IngredientState is loading, IngredientState success -- displays date '
        'when a date is selected',
        setUp: () {
          when(
            () => foodUseCase.getAllIngredients(),
          ).thenAnswer(
              (_) => Future<List<Ingredients>>.value([const Ingredients()]));
        },
        build: () => ingredientBloc,
        act: (bloc) => bloc.add(SelectDateEvent.datePressed(data: "")),
        expect: () => <IngredientState>[
          const IngredientState(
            result: [],
            status: Status.initial,
            search: [],
            isLoading: true,
          ),
          const IngredientState(
            result: [Ingredients()],
            status: Status.success,
            search: [Ingredients()],
            isLoading: false,
          ),
        ],
      );

      // blocTest<LoginBloc, LoginState>(
      //   'emits [LoginInProgress, LoginFailure] when logIn fails',
      //   setUp: () {
      //     when(
      //       () => authenticationRepository.logIn(
      //         username: 'username',
      //         password: 'password',
      //       ),
      //     ).thenThrow(Exception('oops'));
      //   },
      //   build: () => LoginBloc(
      //     authenticationRepository: authenticationRepository,
      //   ),
      //   act: (bloc) {
      //     bloc
      //       ..add(const LoginUsernameChanged('username'))
      //       ..add(const LoginPasswordChanged('password'))
      //       ..add(const LoginSubmitted());
      //   },
      //   expect: () => const <LoginState>[
      //     LoginState(
      //       username: Username.dirty('username'),
      //     ),
      //     LoginState(
      //       username: Username.dirty('username'),
      //       password: Password.dirty('password'),
      //       isValid: true,
      //     ),
      //     LoginState(
      //       username: Username.dirty('username'),
      //       password: Password.dirty('password'),
      //       isValid: true,
      //       status: FormzSubmissionStatus.inProgress,
      //     ),
      //     LoginState(
      //       username: Username.dirty('username'),
      //       password: Password.dirty('password'),
      //       isValid: true,
      //       status: FormzSubmissionStatus.failure,
      //     ),
      //   ],
      // );
    });
  });
}
