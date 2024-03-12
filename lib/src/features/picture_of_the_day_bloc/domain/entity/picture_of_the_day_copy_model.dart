import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/data/dto/picture_of_the_day_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'picture_of_the_day_copy_model.freezed.dart';

@freezed
class PictureOfTheDayCopyModel with _$PictureOfTheDayCopyModel {
  const factory PictureOfTheDayCopyModel({
    required DateTime date,
    required String explanation,
    String? hdUrl,
    required String mediaType,
    required String serviceVersion,
    required String title,
    required String url,
    String? copyright,
  }) = _PictureOfTheDayCopyModel;

  factory PictureOfTheDayCopyModel.fromDto(PictureOfTheDayDto dto) =>
      PictureOfTheDayCopyModel(
        date: dto.date,
        explanation: dto.explanation,
        mediaType: dto.mediaType,
        serviceVersion: dto.serviceVersion,
        title: dto.title,
        url: dto.url,
      );
}
