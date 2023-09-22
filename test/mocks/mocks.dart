import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_tech_task_master/data/datasource/food_data_source.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements FoodService {}

class MockDioResponse extends Mock implements Response {}

class MockFoodUseCase extends Mock implements FoodUseCase {}

class MockIngredientBloc extends MockBloc<SelectDateEvent, IngredientState>
    implements IngredientsBloc {}

class MockRecipeBloc extends MockBloc<RecipeEvent, RecipeState>
    implements RecipeBloc {}
