import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc(this._foodUseCase) : super(RecipeState.initial()) {
    on<RecipeEvent>(_loadRecipe);
  }

  final FoodUseCase _foodUseCase;

  void _loadRecipe(RecipeEvent event, emit) async {
    try {
      if (event is _GetRecipe) {
        emit(state.copyWith(isLoading: true));
        final response =
            await _foodUseCase.getAllRecipe(event.ingredentA, event.ingredentB);

        emit(state.copyWith(result: response, isLoading: false));
      }
    } catch (e, _) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
