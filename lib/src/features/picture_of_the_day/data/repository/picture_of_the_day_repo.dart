import 'package:cosmo_news_to_do/src/core/utils/app_exception.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/source/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';


class PictureOfTheDayRepo {
  PictureOfTheDayRepo({
    required PictureOfTheDayApiProvider pictureOfTheDayApiProvider,
  }) : _pictureOfTheDayApiProvider = pictureOfTheDayApiProvider;


  final PictureOfTheDayApiProvider _pictureOfTheDayApiProvider;

  Future<List<PictureOfTheDayModel>> getPictures({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final picturesMap = await _pictureOfTheDayApiProvider
          .getPictures(startDate,endDate);
      final pictures = picturesMap.map(PictureOfTheDayModel.fromJson).toList().reversed.toList();

      return pictures;
    } on FormatException catch (e, s) {
      Error.throwWithStackTrace(
        AppException(internalMessage: 'Failed to parse picture of the day: $e'),
        s,
      );
    } on Object {
      rethrow;
    }
  }


}
