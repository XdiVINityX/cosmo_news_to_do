import 'package:dio/dio.dart';

class AppScope {
  AppScope() {
    _dio = _initDio();
  }

  late final Dio _dio;

  Dio get dio => _dio;

  Dio _initDio() {
    final dio = Dio();
    dio.options
      ..baseUrl = 'https://api.nasa.gov/'
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..queryParameters = {
        'api_key': '46gbrwXgdBYvqEH2hsN0cXFXYsp3aa1ydxLACElF',
      };

    return dio;
  }
}
