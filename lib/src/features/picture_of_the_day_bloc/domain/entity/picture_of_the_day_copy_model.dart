import 'package:freezed_annotation/freezed_annotation.dart';
part 'picture_of_the_day_copy_model.freezed.dart';
part 'picture_of_the_day_copy_model.g.dart';

@freezed
class PictureOfTheDayCopyModel with _$PictureOfTheDayCopyModel {
  const factory PictureOfTheDayCopyModel({
    required DateTime date,
    required String explanation,
    @JsonKey(name: 'hdurl') String? hdUrl,
    @JsonKey(name: 'media_type') required String mediaType,
    @JsonKey(name: 'service_version') required String serviceVersion,
    required String title,
    required String url,
    String? copyright,
  }) = _PictureOfTheDayCopyModel;

  factory PictureOfTheDayCopyModel.fromJson(Map<String, dynamic> json) =>
      _$PictureOfTheDayCopyModelFromJson(json);
}
