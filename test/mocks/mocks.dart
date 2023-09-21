import 'package:dio/dio.dart';
import 'package:flutter_tech_task_master/data/datasource/food_data_source.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements FoodService {}

class MockDioResponse extends Mock implements Response {}

class MockFoodUseCase extends Mock implements FoodUseCase {}
