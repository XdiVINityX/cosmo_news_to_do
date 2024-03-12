import 'package:cosmo_news_to_do/src/core/utils/app_exception.dart';
import 'package:cosmo_news_to_do/src/core/utils/server_exceptions.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/data/dto/picture_of_the_day_dto.dart';
import 'package:dio/dio.dart';

const endPoint = 'planetary/apod';

class PictureOfTheDayCopyApiProvider {
  PictureOfTheDayCopyApiProvider({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  Future<Iterable<PictureOfTheDayDto>> getPictures(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        endPoint,
        queryParameters: {
          'start_date': '${startDate.year}-${startDate.month}-${startDate.day}',
          'end_date': '${endDate.year}-${endDate.month}-${endDate.day}',
        },
      );
      final data = response.data?.cast<Map<String, dynamic>>().toList() ?? [];
      final picturesDto = data.map(PictureOfTheDayDto.fromJson);

      return picturesDto;
    } on FormatException catch (e, s) {
      Error.throwWithStackTrace(
        AppException(internalMessage: 'Failed to parse picture of the day: $e'),
        s,
      );
    } on DioException catch (e) {
      throw ServerException(e);
    } on Object catch (e) {
      throw AppException(internalMessage: e.toString());
    }
  }
}
