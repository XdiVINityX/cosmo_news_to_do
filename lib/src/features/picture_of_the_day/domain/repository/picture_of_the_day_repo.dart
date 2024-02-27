import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';

class PictureOfTheDayRepo {
   PictureOfTheDayRepo() {
    _pictureOfTheDayApiProvider = PictureOfTheDayApiProvider();
  }
  late final PictureOfTheDayApiProvider _pictureOfTheDayApiProvider;

  Future<List<PictureOfTheDayModel>> getPictures() async {
    final List<PictureOfTheDayModel> dataListObj = [];
    final response = await _pictureOfTheDayApiProvider.getPictures() as List<dynamic>
        ..forEach((element) {
          final pictureOfTheDay = PictureOfTheDayModel.fromJson(element as Map<String,dynamic>);
          dataListObj.add(pictureOfTheDay);
        });
    return dataListObj;
  }
}
