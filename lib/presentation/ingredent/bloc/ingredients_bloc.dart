import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/domain/usecase/food_usecase.dart';

part 'ingredients_event.dart';
part 'ingredients_state.dart';

class IngredientsBloc extends Bloc<SelectDateEvent, IngredientState> {
  IngredientsBloc(this._foodUseCase) : super(IngredientState.initial()) {
    on<SelectDateEvent>(_loadIngredients);
  }

  final FoodUseCase _foodUseCase;

  Future<void> _loadIngredients(SelectDateEvent event, emit) async {
    try {
      if (state.status == Status.initial) {
        emit(state.copyWith(isLoading: true));
        final response = await _foodUseCase.fetchIngredients();

        emit(state.copyWith(
            status: Status.success,
            result: response,
            search: response,
            isLoading: false));
      }
      if (event is _DatePressed) {
        if (event.data.isEmpty) {
          emit(state.copyWith(result: state.search, errorMessage: ""));
        } else {
          var res = state.search
              .where((element) => element.useby!
                  .toLowerCase()
                  .contains(event.data.toLowerCase()))
              .toList();

          if (res.isEmpty) {
            emit(state.copyWith(errorMessage: "Not Found"));
          } else {
            emit(state.copyWith(result: List.of(res)));
          }
        }
      }
    } catch (e, _) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
