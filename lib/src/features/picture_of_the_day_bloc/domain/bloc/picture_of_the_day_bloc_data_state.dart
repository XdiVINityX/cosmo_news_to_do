import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/entity/picture_of_the_day_copy_model.dart';
import 'package:flutter/material.dart';

sealed class PictureOfTheDayBlocDataState {
  DateTimeRange get dateTimeRange;
  List<PictureOfTheDayCopyModel> get pictureOfTheDayResponseData;
}

final class PictureOfTheDayBlocDataStateInitial
    implements PictureOfTheDayBlocDataState {
  const PictureOfTheDayBlocDataStateInitial({
    required this.dateTimeRange,
  });
  @override
  final DateTimeRange dateTimeRange;

  @override
  List<PictureOfTheDayCopyModel> get pictureOfTheDayResponseData => [];
}

/// загрузка данных
final class PictureOfTheDayBlocDataStateLoading
    implements PictureOfTheDayBlocDataState {
  PictureOfTheDayBlocDataStateLoading({
    required this.dateTimeRange,
    required this.pictureOfTheDayResponseData,
  });

  @override
  final List<PictureOfTheDayCopyModel> pictureOfTheDayResponseData;
  @override
  final DateTimeRange dateTimeRange;
}


/// успешное получение данных
final class PictureOfTheDayBlocDataStateSuccess
    implements PictureOfTheDayBlocDataState {
  PictureOfTheDayBlocDataStateSuccess({
    required this.dateTimeRange,
    required this.pictureOfTheDayResponseData,
  });

  @override
  final List<PictureOfTheDayCopyModel> pictureOfTheDayResponseData;
  @override
  final DateTimeRange dateTimeRange;
}

//ошибка
final class PictureOfTheDayBlocDataStateError implements PictureOfTheDayBlocDataState {
  PictureOfTheDayBlocDataStateError({
    required this.dateTimeRange,
    required this.pictureOfTheDayResponseData,
    required this.message,
  });

  @override
  final List<PictureOfTheDayCopyModel> pictureOfTheDayResponseData;
  @override
  final DateTimeRange dateTimeRange;
  final String message;
}
