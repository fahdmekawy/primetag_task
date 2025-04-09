import 'package:hive/hive.dart';

import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<void> addItem(CartItemModel item);

  Future<void> removeItem(int id);

  Future<void> updateItemQuantity(int id, int quantity);

  Future<List<CartItemModel>> getItems();

  Future<double> getTotal();

  Future<void> clear();
}

const String kCartBoxName = 'cartBox';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartItemModel> cartBox;

  CartLocalDataSourceImpl(this.cartBox);

  @override
  Future<void> addItem(CartItemModel item) async {
    if (cartBox.containsKey(item.id)) {
      final existing = cartBox.get(item.id)!;
      final updated = CartItemModel(
        id: item.id,
        title: item.title,
        price: item.price,
        quantity: existing.quantity + item.quantity,
        image: item.image,
      );
      await cartBox.put(item.id, updated);
    } else {
      final newItem = CartItemModel(
        id: item.id,
        title: item.title,
        price: item.price,
        quantity: item.quantity,
        image: item.image,
      );
      await cartBox.put(item.id, newItem);
    }
  }

  @override
  Future<void> removeItem(int id) async {
    await cartBox.delete(id);
  }

  @override
  Future<void> updateItemQuantity(int id, int quantity) async {
    final item = cartBox.get(id);
    if (item != null) {
      final updated = CartItemModel(
        id: item.id,
        title: item.title,
        price: item.price,
        quantity: quantity,
        image: item.image,
      );
      await cartBox.put(id, updated);
    }
  }

  @override
  Future<List<CartItemModel>> getItems() async {
    return cartBox.values.toList();
  }

  @override
  Future<double> getTotal() async {
    final items = cartBox.values.toList();

    return items.fold<double>(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  @override
  Future<void> clear() async {
    await cartBox.clear();
  }
}
