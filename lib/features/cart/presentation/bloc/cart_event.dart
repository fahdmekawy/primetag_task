part of 'cart_bloc.dart';

sealed class CartEvent {}

final class LoadCart extends CartEvent {}

final class AddToCart extends CartEvent {
  final CartItemModel item;

  AddToCart(this.item);
}

final class RemoveFromCart extends CartEvent {
  final int id;

  RemoveFromCart(this.id);
}

final class UpdateQuantity extends CartEvent {
  final int id;
  final int quantity;

  UpdateQuantity(this.id, this.quantity);
}

final class ClearCart extends CartEvent {}
