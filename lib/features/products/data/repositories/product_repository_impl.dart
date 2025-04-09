import 'package:dartz/dartz.dart';
import 'package:primetag_task/features/products/data/models/product_model.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      final products = await remoteDataSource.getAllProducts();
      return Right(products);
    } catch (e) {
      return Left(
        ApiFailure(message: 'Failed to load products', statusCode: 500),
      );
    }
  }
}
