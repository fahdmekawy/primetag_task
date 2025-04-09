import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/cart_item_model.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repo;

  GetCartItemsUseCase(this.repo);

  Future<Either<Failure, List<CartItemModel>>> call() => repo.getCartItems();
}
