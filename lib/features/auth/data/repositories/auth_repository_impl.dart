import 'package:dartz/dartz.dart';
import 'package:primetag_task/core/errors/exceptions.dart';
import 'package:primetag_task/core/errors/failures.dart';
import 'package:primetag_task/features/auth/domain/entities/user.dart';
import 'package:primetag_task/features/auth/domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final UserModel userModel = await remote.login(email, password);
      await local.cacheUser(userModel.token!);
      return Right(userModel.toEntity());
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(
        ApiFailure(
          statusCode: 500,
          message: 'Unexpected error: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<bool> checkAuthStatus() async {
    final token = await local.getCachedUser();
    return token != null;
  }

  @override
  Future<void> logout() async => await local.clearUser();
}
