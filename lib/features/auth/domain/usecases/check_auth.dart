import 'package:primetag_task/features/auth/domain/repositories/auth_repository.dart';

class CheckAuth {
  AuthRepository repository;

  CheckAuth(this.repository);

  Future<bool?> call() => repository.checkAuthStatus();
}
