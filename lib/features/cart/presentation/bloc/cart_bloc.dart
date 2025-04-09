import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cart_item_model.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/clear_cart.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/get_total_price.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/update_quantity.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateQuantityUseCase updateQuantityUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final GetTotalPriceUseCase getTotalPriceUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc(
    this.addToCartUseCase,
    this.removeFromCartUseCase,
    this.updateQuantityUseCase,
    this.getCartItemsUseCase,
    this.getTotalPriceUseCase,
    this.clearCartUseCase,
  ) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final itemsResult = await getCartItemsUseCase();
    final totalResult = await getTotalPriceUseCase();

    itemsResult.fold((failure) => emit(CartError(failure.message)), (items) {
      totalResult.fold(
        (failure) => emit(CartError(failure.message)),
        (total) => emit(CartLoaded(items, total)),
      );
    });
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    await addToCartUseCase(event.item);
    final itemsResult = await getCartItemsUseCase();
    final totalResult = await getTotalPriceUseCase();

    itemsResult.fold((failure) => emit(CartError(failure.message)), (items) {
      totalResult.fold(
        (failure) => emit(CartError(failure.message)),
        (total) => emit(CartLoaded(items, total, justAdded: true)),
      );
    });
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    await removeFromCartUseCase(event.id);
    add(LoadCart());
  }

  Future<void> _onUpdateQuantity(
    UpdateQuantity event,
    Emitter<CartState> emit,
  ) async {
    await updateQuantityUseCase(event.id, event.quantity);
    add(LoadCart());
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    await clearCartUseCase();
    add(LoadCart());
  }
}
