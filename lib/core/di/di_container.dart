import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:primetag_task/features/auth/domain/usecases/check_auth.dart';
import 'package:primetag_task/features/auth/domain/usecases/login.dart';
import 'package:primetag_task/features/auth/domain/usecases/logout.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/products/data/datasource/product_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/get_products.dart';
import '../../features/products/presentation/bloc/product_bloc.dart';
import '../networking/dio_factory.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // ---------------------- AUTH FEATURE -------------------------

  // Initialize Hive
  await Hive.initFlutter();
  final authBox = await Hive.openBox('authBox');
  sl.registerLazySingleton<Box>(() => authBox);

  // DioFactory
  const authBaseUrl = 'https://reqres.in/api';
  final dio = DioFactory.getDio(authBaseUrl);
  sl.registerLazySingleton(() => dio);

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl(), local: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => CheckAuth(sl()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      checkAuthUseCase: sl(),
    ),
  );

  // ---------------------- PRODUCT FEATURE -------------------------

  const productBaseUrl = 'https://fakestoreapi.com';
  final productDio = DioFactory.getDio(productBaseUrl);
  sl.registerLazySingleton<Dio>(() => productDio, instanceName: 'productDio');

  // Data Source
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<Dio>(instanceName: 'productDio')),
  );

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => GetAllProductsUseCase(sl()));

  // Bloc
  sl.registerFactory(() => ProductBloc(sl()));
}
