import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primetag_task/features/products/presentation/bloc/product_event.dart';
import 'package:primetag_task/features/products/presentation/bloc/product_state.dart';
import '../../domain/usecases/get_products.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUseCase getAllProducts;

  ProductBloc(this.getAllProducts) : super(const ProductState.initial()) {
    on<LoadProducts>((event, emit) async {
      emit(const ProductState.loading());
      final result = await getAllProducts();
      result.fold(
        (failure) => emit(ProductState.error(failure.message)),
        (products) => emit(ProductState.loaded(products)),
      );
    });
  }
}
