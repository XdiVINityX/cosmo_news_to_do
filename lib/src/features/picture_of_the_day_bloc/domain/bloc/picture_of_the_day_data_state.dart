import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:flutter/material.dart';

sealed class PictureOfTheDayDataState {
  DateTimeRange get dateTimeRange;
  List<PictureOfTheDayModel> get pictureOfTheDayResponseData;
}

final class PictureOfTheDayDataStateInitial
    implements PictureOfTheDayDataState {
  const PictureOfTheDayDataStateInitial({
    required this.dateTimeRange,
  });
  @override
  final DateTimeRange dateTimeRange;

  @override
  List<PictureOfTheDayModel> get pictureOfTheDayResponseData => [];
}

/// загрузка данных
final class PictureOfTheDayDataStateLoading
    implements PictureOfTheDayDataState {
  PictureOfTheDayDataStateLoading({
    required this.dateTimeRange,
    required this.pictureOfTheDayResponseData,
  });

  @override
  final List<PictureOfTheDayModel> pictureOfTheDayResponseData;
  @override
  final DateTimeRange dateTimeRange;
}

/// успешное получение данных
final class PictureOfTheDayDataStateSuccess
    implements PictureOfTheDayDataState {
  PictureOfTheDayDataStateSuccess({
    required this.dateTimeRange,
    required this.pictureOfTheDayResponseData,
  });

  @override
  final List<PictureOfTheDayModel> pictureOfTheDayResponseData;
  @override
  final DateTimeRange dateTimeRange;
}

//ошибка
final class PictureOfTheDayDataStateError implements PictureOfTheDayDataState {
  PictureOfTheDayDataStateError({
    required this.dateTimeRange,
    required this.pictureOfTheDayResponseData,
    required this.message,
  });

  @override
  final List<PictureOfTheDayModel> pictureOfTheDayResponseData;
  @override
  final DateTimeRange dateTimeRange;
  final String message;
}
