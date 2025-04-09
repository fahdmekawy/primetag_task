import 'package:dartz/dartz.dart';
import 'package:primetag_task/features/products/domain/entities/product.dart';
import '../../../../core/errors/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
}
