import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();

  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}
