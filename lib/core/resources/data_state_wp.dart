abstract class DataStateWp<T, P> {
  final T? data;
  final P? param;
  final String? error;

  const DataStateWp(this.data, this.param, this.error);
}

class DataSuccessWp<T, P> extends DataStateWp<T, P> {
  const DataSuccessWp(T? data, {P? param}) : super(data, param, null);
}

class DataFailedWp<T, P> extends DataStateWp<T, P> {
  const DataFailedWp(String? error, {P? param}) : super(null, param, error);
}
