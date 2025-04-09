part of 'cart_bloc.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final double total;
  final bool justAdded;

  CartLoaded(this.items, this.total, {this.justAdded = false});
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);
}
