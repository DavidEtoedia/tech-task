part of 'ingredients_bloc.dart';

class SelectDateEvent extends Equatable {
  const SelectDateEvent();

  factory SelectDateEvent.started() => const _Started();

  factory SelectDateEvent.datePressed({
    required String data,
  }) {
    return _DatePressed(data: data);
  }

  @override
  List<Object?> get props => [];
}

class _Started extends SelectDateEvent {
  const _Started();
}

class _DatePressed extends SelectDateEvent {
  final String data;

  const _DatePressed({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}
