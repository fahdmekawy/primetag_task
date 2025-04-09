import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static final Map<String, Dio> _dioMap = {};

  static Dio getDio(String baseUrl) {
    if (_dioMap.containsKey(baseUrl)) return _dioMap[baseUrl]!;

    final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          // headers: {
          //   'Content-Type': 'application/json',
          //   'Accept': 'application/json',
          // },
        ),
      )
      ..interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );

    _dioMap[baseUrl] = dio;
    return dio;
  }
}
