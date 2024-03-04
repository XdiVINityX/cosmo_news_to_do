import 'package:cosmo_news_to_do/src/core/utils/app_exception.dart';
import 'package:dio/dio.dart';

class ServerException extends AppException {
  factory ServerException([DioException? dioException]) {
    switch (dioException?.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException._(dioException, message: 'Соединение прервано');
      case DioExceptionType.sendTimeout:
        throw ServerException._(dioException, message: 'Время отправки вышло');
      case DioExceptionType.receiveTimeout:
        throw ServerException._(dioException, message: 'Время получения вышло');
      case DioExceptionType.badCertificate:
        throw ServerException._(dioException, message: 'Неверный сертификат');
      case DioExceptionType.badResponse:
        throw ServerException._(dioException, message: 'Неверный ответ');
      case DioExceptionType.cancel:
        throw ServerException._(dioException, message: 'отмена');
      case DioExceptionType.connectionError:
        throw ServerException._(dioException, message: 'Ошибка соединения');
      case DioExceptionType.unknown:
        throw ServerException._(dioException, message: 'Неизвестная ошибка');
      case null:
        break;
    }

    return ServerException._(
      dioException,
    );
  }
  ServerException._(
    DioException? exception, {
    super.message,
  }) : super(
          internalMessage:
              '${exception?.response?.data ?? exception?.message ?? exception?.error}',
        );
}
