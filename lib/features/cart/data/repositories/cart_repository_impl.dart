import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource local;

  CartRepositoryImpl(this.local);

  @override
  Future<Either<Failure, void>> addToCart(CartItemModel item) async {
    try {
      await local.addItem(item);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Add to cart failed'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(int id) async {
    try {
      await local.removeItem(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Remove from cart failed'));
    }
  }

  @override
  Future<Either<Failure, List<CartItemModel>>> getCartItems() async {
    try {
      final items = await local.getItems();
      return Right(items);
    } catch (e) {
      return Left(CacheFailure(message: 'Get cart items failed'));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuantity(int id, int quantity) async {
    try {
      await local.updateItemQuantity(id, quantity);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Update quantity failed'));
    }
  }

  @override
  Future<Either<Failure, double>> getTotalPrice() async {
    try {
      final total = await local.getTotal();
      return Right(total);
    } catch (e) {
      return Left(CacheFailure(message: 'Get total failed'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await local.clear();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Clear cart failed'));
    }
  }
}
