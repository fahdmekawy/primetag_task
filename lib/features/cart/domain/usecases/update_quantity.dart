import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class UpdateQuantityUseCase {
  final CartRepository repo;

  UpdateQuantityUseCase(this.repo);

  Future<Either<Failure, void>> call(int id, int quantity) =>
      repo.updateQuantity(id, quantity);
}
