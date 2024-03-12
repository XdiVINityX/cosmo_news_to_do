import 'package:freezed_annotation/freezed_annotation.dart';

part 'picture_of_the_day_dto.g.dart';

@JsonSerializable()
class PictureOfTheDayDto {
  const PictureOfTheDayDto({
    required this.date,
    required this.explanation,
    this.hdUrl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
    this.copyright,
  });

  factory PictureOfTheDayDto.fromJson(Map<String, dynamic> json) =>
      _$PictureOfTheDayDtoFromJson(json);
  final DateTime date;
  final String explanation;
  @JsonKey(name: 'hdurl')
  final String? hdUrl;
  @JsonKey(name: 'media_type')
  final String mediaType;
  @JsonKey(name: 'service_version')
  final String serviceVersion;
  final String title;
  final String url;
  final String? copyright;
}
