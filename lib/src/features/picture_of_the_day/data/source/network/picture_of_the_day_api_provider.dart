import 'package:cosmo_news_to_do/src/features/app/presentation/data/source/network/dio_app_scope.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/exception/failure.dart';
import 'package:dio/dio.dart';

const baseUrl = 'https://api.nasa.gov/';
const endPoint = 'planetary/apod?';
const apiKey = '46gbrwXgdBYvqEH2hsN0cXFXYsp3aa1ydxLACElF';

// TODO(add): добавить возможность получения определенной даты в запрос.
class PictureOfTheDayApiProvider {

 PictureOfTheDayApiProvider({
    required this.dio,
  });

final DioAppScope dio;


  Future<List<Map<String, dynamic>>> getPictures(DateTime startDate) async {
    try {
      final response = await dio.get('https://api.nasa.gov/planetary/apod',
        queryParameters: {
          'api_key': apiKey,
          'start_date': '${startDate.year}-${startDate.month}-${startDate.day}',
        },
      );
      return response;

    } on DioException catch (e) {
      print(e.stackTrace);
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw const Failure(message: 'Соединение прервано');
        case DioExceptionType.sendTimeout:
          throw const Failure(message: 'Время отправки вышло');
        case DioExceptionType.receiveTimeout:
          throw const Failure(message: 'Время получения вышло');
        case DioExceptionType.badCertificate:
          throw const Failure(message: 'Неверный сертификат');
        case DioExceptionType.badResponse:
          throw const Failure(message: 'Неверный ответ');
        case DioExceptionType.cancel:
          throw const Failure(message: 'отмена');
        case DioExceptionType.connectionError:
          throw const Failure(message: 'Ошибка соединения');
        case DioExceptionType.unknown:
          throw const Failure(message: 'Неизвестная ошибка');
      }

      // switch (e.response?.statusCode) {}
      Error.throwWithStackTrace(Exception(e), e.stackTrace);
    }
  }

}
