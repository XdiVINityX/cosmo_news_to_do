import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/data_state_picture_of_the_day.dart';
import 'package:flutter/foundation.dart';


class PictureOfTheDayViewModel extends ChangeNotifier {
  PictureOfTheDayViewModel(){
    state = PictureOfTheDayDataStateLoading();
    init();
}

  late  PictureOfTheDayDataState state;
  late final PictureOfTheDayRepo _repo;
  final List<PictureOfTheDayModel> dataListObj = [];

  Future<void> init() async {
    _repo = PictureOfTheDayRepo();
    // TODO(error): check error.
    final data = await _repo.getPictures();
    data.forEach(dataListObj.add);
    state = PictureOfTheDayDataStateSuccess(pictureOfTheDayResponseData: dataListObj );
    notifyListeners();
  }

}
