import 'package:cosmo_news_to_do/src/core/utils/app_exception.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/picture_of_the_day_data_state.dart';
import 'package:flutter/material.dart';

class PictureOfTheDayViewModel extends ChangeNotifier {
  PictureOfTheDayViewModel(this._repository)
      : _state = PictureOfTheDayDataStateInitial(
          dateTimeRange: DateTimeRange(
            start: DateTime.now().add(const Duration(days: -7)),
            end: DateTime.now(),
          ),
        );

  late PictureOfTheDayDataState _state;

  final PictureOfTheDayRepo _repository;
  PictureOfTheDayDataState get state => _state;

  Future<void> loadPictures() async {
    try {
      final data = await _repository.getPictures(
        startDate: _state.dateTimeRange.start,
        endDate: _state.dateTimeRange.end,
      );
      const duration = Duration(days: -8);
      final nextDtRange = DateTimeRange(
        start: _state.dateTimeRange.start.add(duration),
        end: _state.dateTimeRange.end.add(duration),
      );
      _state = PictureOfTheDayDataStateSuccess(
        dateTimeRange: nextDtRange,
        pictureOfTheDayResponseData: [
          ..._state.pictureOfTheDayResponseData,
          ...data,
        ],
      );
      notifyListeners();
    } on AppException catch (e) {
      _state = PictureOfTheDayDataStateError(
        dateTimeRange: _state.dateTimeRange,
        pictureOfTheDayResponseData: state.pictureOfTheDayResponseData,
        message: e.message,
      );
      notifyListeners();

      rethrow;
    }
  }

  Future<void> loadMore() async {
    _state = PictureOfTheDayDataStateLoading(
      dateTimeRange: _state.dateTimeRange,
      pictureOfTheDayResponseData: _state.pictureOfTheDayResponseData,
    );
    notifyListeners();
    try {
      await loadPictures();
    } finally {
      _state = PictureOfTheDayDataStateSuccess(
        dateTimeRange: _state.dateTimeRange,
        pictureOfTheDayResponseData: _state.pictureOfTheDayResponseData,
      );
      notifyListeners();
    }
  }
}
