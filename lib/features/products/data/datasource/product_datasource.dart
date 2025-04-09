import 'package:dio/dio.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await dio.get('/products');
    final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}
