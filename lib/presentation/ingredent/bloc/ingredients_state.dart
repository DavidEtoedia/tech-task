part of 'ingredients_bloc.dart';

enum Status { initial, success, failure }

class IngredientState extends Equatable {
  final List<Ingredients> result;
  final List<Ingredients> search;
  final String? errorMessage;
  final Status status;
  final bool isLoading;

  const IngredientState({
    this.errorMessage = "",
    required this.result,
    required this.status,
    required this.search,
    required this.isLoading,
  });

  factory IngredientState.initial() {
    return const IngredientState(
      result: [],
      search: [],
      errorMessage: "",
      status: Status.initial,
      isLoading: false,
    );
  }

  IngredientState copyWith({
    String? errorMessage,
    bool? isLoading,
    Status? status,
    List<Ingredients>? search,
    List<Ingredients>? result,
  }) {
    return IngredientState(
      result: result ?? this.result,
      search: search ?? this.search,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''IngredientState {result: ${result.length}, search: ${search.length} , loading: $isLoading, status: $status , errorMessage: $errorMessage }''';
  }

  @override
  List<Object?> get props => [result, status, search, isLoading, errorMessage];

  @override
  bool? get stringify => true;
}
