import 'package:cosmo_news_to_do/src/core/utils/app_exception.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/data_state_picture_of_the_day.dart';
import 'package:flutter/foundation.dart';

class PictureOfTheDayViewModel extends ChangeNotifier {
  PictureOfTheDayViewModel(this._repository) {
    init();
  }

  late PictureOfTheDayDataState state;
  late DateTime _startDate;
  final PictureOfTheDayRepo _repository;
  late bool _isInit;

  void init() {
    _isInit = true;
    state = PictureOfTheDayDataStateLoading();
    _startDate = DateTime.now().subtract(const Duration(days: 7));
    getPictures();
  }

  Future<void> getPictures() async {
    final DateTime endDate = _startDate.add(const Duration(days: 7));
    try {
      final data = await _repository.getPictures(
        startDate: _startDate,
        endDate: endDate,
      );
      _decreaseDataByWeek();
      state = PictureOfTheDayDataStateSuccess(
        pictureOfTheDayResponseData: data,
      );
      if (_isInit) {
        notifyListeners();
        _isInit = !_isInit;
      }
    } on AppException catch (e) {
      state = PictureOfTheDayDataStateError(
        pictureOfTheDayResponseData: [],
        message: e.message,
      );
      notifyListeners();
    } on Object catch (e) {
      state = PictureOfTheDayDataStateError(
        pictureOfTheDayResponseData: [],
        message: e.toString(),
      );
      notifyListeners();
      rethrow;
    }
  }

  void _decreaseDataByWeek() {
    _startDate = _startDate.subtract(const Duration(days: 8));
  }
}
