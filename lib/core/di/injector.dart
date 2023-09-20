import 'package:flutter_tech_task_master/core/service/network_service.dart';
import 'package:flutter_tech_task_master/data/datasource/food_data_source.dart';
import 'package:flutter_tech_task_master/data/datasource/food_impl_manager.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

Future<void> initializeCore() async {
  _initBloc();
  _initServices();
  _initRepositories();
  _initializeUsecase();
}

/// Initialize bloc's here
void _initBloc() {
  inject
      .registerLazySingleton<IngredientsBloc>(() => IngredientsBloc(inject()));
}

///----------------------------------------->

/// Initialize services's here
void _initServices() {
  inject.registerLazySingleton<NetworkService>(() => NetworkService());
  inject.registerLazySingleton<FoodService>(
      () => FoodService(httpService: inject()));
}

/// Initialize repository implementations
void _initRepositories() {
  inject
      .registerLazySingleton<FoodImplManager>(() => FoodImplManager(inject()));
}

/// Initialize Food use case here
void _initializeUsecase() {
  inject.registerLazySingleton<FoodUseCase>(
      () => FoodUseCase(foodImplManager: inject()));
}
