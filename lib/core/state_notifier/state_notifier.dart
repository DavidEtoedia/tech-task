import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_notifier.freezed.dart';

@freezed
class RequestState<T> with _$RequestState<T> {
  const factory RequestState.idle() = Idle<T>;

  const factory RequestState.loading() = Loading<T>;

  const factory RequestState.success(T? value) = Success<T>;

  const factory RequestState.error(Object error, StackTrace stackTrace) =
      Error<T>;
}

extension RequestStateExtensions<T> on RequestState<T> {
  T? get successValue =>
      maybeWhen(success: (value) => value, orElse: () => null);
  Object? get errorValue =>
      maybeWhen(error: (error, _) => error, orElse: () => null);
  StackTrace? get errorStackTrace =>
      maybeWhen(error: (_, stackTrace) => stackTrace, orElse: () => null);
  bool get hasError => maybeWhen(error: (_, __) => true, orElse: () => false);
  bool get isSuccess => maybeWhen(success: (_) => true, orElse: () => false);
  bool get hasValue => maybeWhen(success: (_) => true, orElse: () => false);
  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);
}
