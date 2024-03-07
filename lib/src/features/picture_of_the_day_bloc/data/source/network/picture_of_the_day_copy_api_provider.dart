import 'package:cosmo_news_to_do/src/core/utils/app_exception.dart';
import 'package:cosmo_news_to_do/src/core/utils/server_exceptions.dart';
import 'package:dio/dio.dart';
const endPoint = 'planetary/apod';

class PictureOfTheDayCopyApiProvider {
  PictureOfTheDayCopyApiProvider({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  Future<List<Map<String, dynamic>>> getPictures(DateTime startDate, DateTime endDate,) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        endPoint,
        queryParameters: {
          'start_date': '${startDate.year}-${startDate.month}-${startDate.day}',
          'end_date': '${endDate.year}-${endDate.month}-${endDate.day}',
        },
      );
      final data = response.data?.cast<Map<String, dynamic>>().toList() ?? [];
      return data;
    } on DioException catch (e) {
      throw ServerException(e);
    } on Object catch (e){
      throw AppException(internalMessage: e.toString());
    }
  }
}
