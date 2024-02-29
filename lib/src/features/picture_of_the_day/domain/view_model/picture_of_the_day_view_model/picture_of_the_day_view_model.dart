import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/data_state_picture_of_the_day.dart';
import 'package:flutter/foundation.dart';

// TODO(req): req repo
class PictureOfTheDayViewModel extends ChangeNotifier {
  PictureOfTheDayViewModel(this._repository){
    state = PictureOfTheDayDataStateLoading();
    init();
}
  final PictureOfTheDayRepo _repository;
  late  PictureOfTheDayDataState state;
  final List<PictureOfTheDayModel> picturesOfTheDay = [];

  Future<void> init() async {

    // TODO(error): check error.
    final data = await _repository.getPictures();
    data.forEach(picturesOfTheDay.add);
    state = PictureOfTheDayDataStateSuccess(pictureOfTheDayResponseData: picturesOfTheDay );
    notifyListeners();
  }
}
