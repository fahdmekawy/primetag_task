import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/cart_item_model.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repo;

  AddToCartUseCase(this.repo);

  Future<Either<Failure, void>> call(CartItemModel item) =>
      repo.addToCart(item);
}
