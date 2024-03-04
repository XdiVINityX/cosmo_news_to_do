import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/source/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';


class PictureOfTheDayRepo {
  PictureOfTheDayRepo({
    required this.pictureOfTheDayApiProvider,
  }) : currentWeek = DateTime.now().subtract(const Duration(days: 7));

  final PictureOfTheDayApiProvider pictureOfTheDayApiProvider;
  DateTime currentWeek;


  Future<List<PictureOfTheDayModel>> getPictures() async {
    try {
      final picturesMap = await pictureOfTheDayApiProvider
          .getPictures(currentWeek);
      _decreaseDataByWeek();
      final pictures = picturesMap.map(PictureOfTheDayModel.fromJson).toList().reversed.toList();

      return pictures;
    } on FormatException catch (e, s) {
      Error.throwWithStackTrace(
        Exception('Failed to parse picture of the day: $e'),
        s,
      );
    } on Object {
      rethrow;
    }
  }

  void _decreaseDataByWeek(){
    currentWeek = currentWeek.subtract(const Duration(days: 7));
  }
}
