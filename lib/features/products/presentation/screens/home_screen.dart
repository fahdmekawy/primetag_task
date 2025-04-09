import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primetag_task/features/cart/data/models/cart_item_model.dart';
import 'package:primetag_task/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:primetag_task/features/products/presentation/bloc/product_bloc.dart';
import 'package:primetag_task/features/products/presentation/bloc/product_state.dart';

import '../../../cart/presentation/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int count = 0;
              if (state is CartLoaded) {
                count = state.items.fold(0, (sum, item) => sum + item.quantity);
              }
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart, size: 35),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 2,
                      top: 2,
                      child: Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: FittedBox(
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocListener<CartBloc, CartState>(
        listenWhen:
            (previous, current) =>
                previous is! CartLoaded && current is CartLoaded,
        listener: (context, state) {
          if (state is CartLoaded && state.justAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product added to cart!'),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is Initial || state is Loading) {
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
                      subtitle: Text(
                        '\$${product.price?.toStringAsFixed(2) ?? ''}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          context.read<CartBloc>().add(
                            AddToCart(
                              CartItemModel(
                                id: product.id!,
                                title: product.title!,
                                price: product.price!,
                                quantity: 1,
                                image: product.image!,
                              ),
                            ),
                          );
                        },
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
