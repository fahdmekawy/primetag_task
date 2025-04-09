import 'package:dartz/dartz.dart';
import 'package:primetag_task/features/auth/domain/entities/user.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);

  Future<void> logout();

  Future<bool> checkAuthStatus();
}
