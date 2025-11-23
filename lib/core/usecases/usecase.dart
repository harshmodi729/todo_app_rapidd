import 'package:fpdart/fpdart.dart';
import 'package:todo_app/core/errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

abstract class NoParamsUseCase<Type> extends UseCase<Type, void> {
  @override
  Future<Either<Failure, Type>> call({void params});
}

class NoParams {}