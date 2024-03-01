import 'package:cosmo_news_to_do/src/core/utils/app_exception.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/data_state_picture_of_the_day.dart';
import 'package:flutter/foundation.dart';

// TODO(req): req repo
class PictureOfTheDayViewModel extends ChangeNotifier {
  PictureOfTheDayViewModel(this._repository) {
    state = PictureOfTheDayDataStateLoading();
    init();
  }
  final PictureOfTheDayRepo _repository;
  late PictureOfTheDayDataState state;

  Future<void> init() async {
    try {
      // TODO(error): check error.
      final data = await _repository.getPictures();
      state = PictureOfTheDayDataStateSuccess(
        pictureOfTheDayResponseData: data,
      );
      notifyListeners();
    } on AppException catch (e) {
      state = PictureOfTheDayDataStateError(
        pictureOfTheDayResponseData: [],
        message: e.message,
      );

      rethrow;
    }
  }
}
