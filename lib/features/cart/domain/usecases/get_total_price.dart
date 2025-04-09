import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/cart_repository.dart';

class GetTotalPriceUseCase {
  final CartRepository repo;

  GetTotalPriceUseCase(this.repo);

  Future<Either<Failure, double>> call() => repo.getTotalPrice();
}
