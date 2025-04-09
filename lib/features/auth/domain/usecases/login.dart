import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:primetag_task/core/errors/failures.dart';
import 'package:primetag_task/core/usecase/usecase.dart';
import 'package:primetag_task/features/auth/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class Login extends UseCaseWithParams<User, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) =>
      repository.login(params.email, params.password);
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
