abstract class DataState<T> {
  final T? data;
  final String? error;

  const DataState(this.data, this.error);
}

class DataSuccess<T> extends DataState<T> {
  final Object? param;
  const DataSuccess(T? data, {this.param}) : super(data, null);
}

class DataFailed<T> extends DataState<T> {
  final Object? param;
  const DataFailed(String? error, {this.param}) : super(null, error);
}
