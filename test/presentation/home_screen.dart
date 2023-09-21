import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/core/di/injector.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/ingredient_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIngredientBloc extends MockBloc<SelectDateEvent, IngredientState>
    implements IngredientsBloc {}

void main() {
  late MockIngredientBloc ingredientBloc;

  setUp(() {
    ingredientBloc = MockIngredientBloc();
    initializeCore();
  });

  tearDown(() {
    inject.reset();
  });

  testWidgets('Find Specific text on the screen', (WidgetTester tester) async {
    whenListen(
      ingredientBloc,
      Stream.fromIterable([
        const IngredientState(
            result: [], status: Status.initial, search: [], isLoading: true),
        const IngredientState(
            result: [
              Ingredients(),
            ],
            status: Status.success,
            search: [Ingredients()],
            isLoading: false),
      ]),
      initialState: const IngredientState(
          result: [], status: Status.initial, search: [], isLoading: false),
    );
    await tester.pumpWidget(
      BlocProvider<IngredientsBloc>.value(
        value: ingredientBloc,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    var findText =
        find.textContaining("Select only 2 ingredients and get their recipes");
    var getRecipeButton = find.textContaining("Get Recipe");

    await tester.pumpAndSettle();
    expect(findText, findsOneWidget);
    expect(getRecipeButton, findsOneWidget);
  });

  testWidgets('Find a circular progress indicator',
      (WidgetTester tester) async {
    when(() => ingredientBloc.state).thenReturn(const IngredientState(
        result: [], status: Status.initial, search: [], isLoading: true));
    await tester.pumpWidget(
      BlocProvider<IngredientsBloc>.value(
        value: ingredientBloc,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Find a Gridview when is success', (WidgetTester tester) async {
    when(() => ingredientBloc.state).thenReturn(const IngredientState(
        result: [Ingredients(title: "Ham", useby: "2020-12-03")],
        status: Status.success,
        search: [Ingredients(title: "Ham", useby: "2020-12-03")],
        isLoading: false));
    await tester.pumpWidget(
      BlocProvider<IngredientsBloc>.value(
        value: ingredientBloc,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.byType(GridView), findsOneWidget);
  });
}
