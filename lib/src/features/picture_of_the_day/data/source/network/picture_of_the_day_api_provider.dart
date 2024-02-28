import 'package:dio/dio.dart';

const baseUrl = 'https://api.nasa.gov/';
const endPoint = 'planetary/apod?';
const apiKey = '46gbrwXgdBYvqEH2hsN0cXFXYsp3aa1ydxLACElF';

// TODO(add): добавить возможность получения определенной даты в запрос.
class PictureOfTheDayApiProvider {
  PictureOfTheDayApiProvider({
    required Dio client,
  }) : _client = client;
  final Dio _client;

  Future<List<Map<String, dynamic>>> getPictures(DateTime startDate) async {
    try {
      final response = await _client.get<List<Object?>>(
        'planetary/apod',
        queryParameters: {
          'api_key': apiKey,
          'start_date': '${startDate.year}-${startDate.month}-${startDate.day}',
        },
      );

      return response.data?.cast<Map<String, dynamic>>() ?? [];
      // final response = await Dio().get<dynamic>(
      //   '$baseUrl$endPoint$apiKey&start_date=2024-1-26',
      // );
      // return response.data;}
    } on DioException catch (e) {
      // switch(e.type) {
      //   case DioExceptionType.connectionTimeout:
      //     // `TODO`: Handle this case.
      //   case DioExceptionType.sendTimeout:
      //     // `TODO`: Handle this case.
      //   case DioExceptionType.receiveTimeout:
      //     // `TODO`: Handle this case.
      //   case DioExceptionType.badCertificate:
      //     // `TODO`: Handle this case.
      //   case DioExceptionType.badResponse:
      //     // `TODO`: Handle this case.
      //   case DioExceptionType.cancel:
      //     // `TODO`: Handle this case.
      //   case DioExceptionType.connectionError:
      //     // `TODO`: Handle this case.
      //   case DioExceptionType.unknown:
      //     // `TODO`: Handle this case.
      // }
      // switch (e.response?.statusCode) {}
      Error.throwWithStackTrace(Exception(e), e.stackTrace);
    }
  }
}
