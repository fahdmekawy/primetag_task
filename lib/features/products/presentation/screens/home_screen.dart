import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primetag_task/features/products/presentation/bloc/product_bloc.dart';
import 'package:primetag_task/features/products/presentation/bloc/product_event.dart';
import 'package:primetag_task/features/products/presentation/bloc/product_state.dart';

import '../../../../core/di/di_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Products'), centerTitle: true),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is Initial || state is Loading) {
              context.read<ProductBloc>().add(
                const ProductEvent.loadProducts(),
              );
              return const Center(child: CircularProgressIndicator());
            } else if (state is Error) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is Loaded) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Image.network(
                        product.image ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        product.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
