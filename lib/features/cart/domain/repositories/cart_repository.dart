import '../entities/cart.dart';

abstract class CartRepository {
  Future<void> addToCart(Cart cart);

  Future<void> removeFromCart(Cart cart);

  Future<List<Cart>> getCartItems();

  Future<void> clearCart();
}
