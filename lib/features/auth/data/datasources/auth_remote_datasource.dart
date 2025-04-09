import 'package:dio/dio.dart';
import 'package:primetag_task/core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ApiException(
          statusCode: response.statusCode ?? 500,
          message: response.data['error'] ?? 'Unknown error',
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode ?? 500,
        message: e.message ?? 'API request failed',
      );
    }
  }
}
