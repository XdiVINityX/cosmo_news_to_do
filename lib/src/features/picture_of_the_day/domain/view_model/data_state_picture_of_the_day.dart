import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';

sealed class PictureOfTheDayDataState {
  List<PictureOfTheDayModel> get pictureOfTheDayResponseData;
}
//успешное получение данных
final class PictureOfTheDayDataStateSuccess implements PictureOfTheDayDataState{
const PictureOfTheDayDataStateSuccess({
    required this.pictureOfTheDayResponseData,
  });

@override
  final List<PictureOfTheDayModel> pictureOfTheDayResponseData;
}

//загрузка данных
final class PictureOfTheDayDataStateLoading implements PictureOfTheDayDataState{
PictureOfTheDayDataStateLoading() : pictureOfTheDayResponseData = [];

  @override
  List<PictureOfTheDayModel> pictureOfTheDayResponseData;
}

//ошибка
final class PictureOfTheDayDataStateError implements PictureOfTheDayDataState{

  const PictureOfTheDayDataStateError({
    required this.pictureOfTheDayResponseData,
    required this.message,
  });
  @override
  final List<PictureOfTheDayModel> pictureOfTheDayResponseData;
  final String message;

}

