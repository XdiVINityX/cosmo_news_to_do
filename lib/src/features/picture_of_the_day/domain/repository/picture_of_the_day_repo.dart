import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:dio/dio.dart';

class PictureOfTheDayRepo {
  PictureOfTheDayRepo() {
    // TODO(fix): ВЫНЕСТИ DIP
    _pictureOfTheDayApiProvider = PictureOfTheDayApiProvider(
      client: Dio(
        BaseOptions(
          baseUrl: 'https://api.nasa.gov/',
        ),
      ),
    );
  }
  late final PictureOfTheDayApiProvider _pictureOfTheDayApiProvider;

  Future<List<PictureOfTheDayModel>> getPictures() async {
    try {
      final picturesMap = await _pictureOfTheDayApiProvider
          .getPictures(DateTime.now().copyWith(month: 1));
      final pictures = picturesMap.map(PictureOfTheDayModel.fromJson).toList();
      return pictures;
    } on FormatException catch (e, s) {
      Error.throwWithStackTrace(
          Exception('Failed to parse picture of the day: $e'), s);
    } on Object {
      rethrow;
    }
    // final List<PictureOfTheDayModel> dataListObj = [];
    // final response =
    //     await _pictureOfTheDayApiProvider.getPictures() as List<dynamic>
    //       ..forEach((element) {
    //         final pictureOfTheDay =
    //             PictureOfTheDayModel.fromJson(element as Map<String, dynamic>);
    //         dataListObj.add(pictureOfTheDay);
    //       });
    // return dataListObj;
  }
}
