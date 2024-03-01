import 'package:cosmo_news_to_do/src/core/utils/server_exceptions.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/exception/failure.dart';
import 'package:dio/dio.dart';

const baseUrl = 'https://api.nasa.gov/';
const endPoint = 'planetary/apod?';
const apiKey = '46gbrwXgdBYvqEH2hsN0cXFXYsp3aa1ydxLACElF';

// TODO(add): добавить возможность получения определенной даты в запрос.
class PictureOfTheDayApiProvider {
  PictureOfTheDayApiProvider({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  Future<List<Map<String, dynamic>>> getPictures(DateTime startDate) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '/planetary/apod',
        queryParameters: {
          'api_key': apiKey,
          'start_date': '${startDate.year}-${startDate.month}-${startDate.day}',
        },
      );

      final data = response.data?.cast<Map<String, dynamic>>().toList() ?? [];

      return data;
    } on DioException catch (e) {
      Error.throwWithStackTrace(ServerException(e), e.stackTrace);
    }
  }
}
