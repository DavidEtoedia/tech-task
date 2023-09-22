import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/core/di/injector.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:flutter_tech_task_master/presentation/recipe/recipe_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late MockRecipeBloc recipeBloc;

  setUp(() {
    recipeBloc = MockRecipeBloc();
    initializeCore();
  });

  tearDown(() {
    inject.reset();
  });

  testWidgets('Find Recipe text  on Recipe screen',
      (WidgetTester tester) async {
    whenListen(
      recipeBloc,
      Stream.fromIterable([
        const RecipeState(result: [
          RecipeModel(title: "Ham", ingredients: ["cheese"])
        ], isLoading: true),
        const RecipeState(result: [
          RecipeModel(title: "Ham", ingredients: ["cheese"])
        ], isLoading: false),
      ]),
      initialState: const RecipeState(result: [
        RecipeModel(title: "Ham", ingredients: ["cheese"])
      ], isLoading: false),
    );
    await tester.pumpWidget(
      BlocProvider<RecipeBloc>.value(
        value: recipeBloc,
        child: const MaterialApp(home: RecipeScreen()),
      ),
    );

    var findText = find.textContaining("Recipe");

    await tester.pumpAndSettle();
    expect(findText, findsOneWidget);
  });

  testWidgets('Find a circular progress indicator',
      (WidgetTester tester) async {
    when(() => recipeBloc.state)
        .thenReturn(const RecipeState(result: [], isLoading: true));
    await tester.pumpWidget(
      BlocProvider<RecipeBloc>.value(
        value: recipeBloc,
        child: const MaterialApp(home: RecipeScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Find a Gridview when is success', (WidgetTester tester) async {
    when(() => recipeBloc.state).thenReturn(const RecipeState(result: [
      RecipeModel(title: "Ham", ingredients: ["cheese"])
    ], isLoading: false));
    await tester.pumpWidget(
      BlocProvider<RecipeBloc>.value(
        value: recipeBloc,
        child: const MaterialApp(home: RecipeScreen()),
      ),
    );

    expect(find.byType(GridView), findsOneWidget);
  });
}
