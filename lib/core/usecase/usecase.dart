abstract class UseCase<T> {
  Future<T> call();
}

abstract class UseCaseWithParam<T, P> {
  Future<T> call(P param);
}

abstract class UseCaseStream<T> {
  Stream<T> call();
}

abstract class UseCaseStreamWithParam<T, P> {
  Stream<T> call(P param);
}
