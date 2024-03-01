import 'package:dio/dio.dart';

class DioAppScope {
  final Dio _dio = Dio(BaseOptions())
    ..interceptors.add(LogInterceptor(error: true, request: true));

  Future<List<Map<String, dynamic>>> get(
    String baseUrl, {
    required Map<String, String> queryParameters,
  }) async {
    final response = await _dio.get<List<Object?>>(
      baseUrl,
      queryParameters: queryParameters,
    );
    return response.data?.cast<Map<String, dynamic>>() ?? [];
  }
}
