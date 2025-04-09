import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primetag_task/features/products/presentation/bloc/product_event.dart';
import 'app_start_page.dart';
import 'core/di/di_container.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/products/presentation/bloc/product_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  // Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(const CheckAuthEvent()),
        ),
        BlocProvider(create: (context) => sl<CartBloc>()..add(LoadCart())),
        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(LoadProducts()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AppStartPage(),
    );
  }
}
