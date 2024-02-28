import 'package:json_annotation/json_annotation.dart';
part 'picture_of_the_day_model.g.dart';

@JsonSerializable()
class PictureOfTheDayModel {
  PictureOfTheDayModel({
    required this.date,
    required this.explanation,
    this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
    this.copyright,
  });

  factory PictureOfTheDayModel.fromJson(Map<String, dynamic> json) =>
      _$PictureOfTheDayModelFromJson(json);
  final DateTime? date;
  final String? explanation;
  final String? hdurl;
  @JsonKey(name: 'media_type')
  final MediaType? mediaType;
  @JsonKey(name: 'service_version')
  final ServiceVersion? serviceVersion;
  final String? title;
  final String? url;
  final String? copyright;

  Map<String, dynamic> toJson() => _$PictureOfTheDayModelToJson(this);
}

enum MediaType { image, video }

final mediaTypeValues = EnumValues({
  'image': MediaType.image,
  'video': MediaType.video,
});

enum ServiceVersion {
  @JsonValue('v1')
  v1
}

final serviceVersionValues = EnumValues({
  'v1': ServiceVersion.v1,
});

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T> map;
  late Map<T, String> reverseMap;
}
