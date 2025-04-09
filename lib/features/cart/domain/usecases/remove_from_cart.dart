import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repo;

  RemoveFromCartUseCase(this.repo);

  Future<Either<Failure, void>> call(int id) => repo.removeFromCart(id);
}
