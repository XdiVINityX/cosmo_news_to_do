// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_of_the_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PictureOfTheDayModel _$PictureOfTheDayModelFromJson(
        Map<String, dynamic> json) =>
    PictureOfTheDayModel(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      explanation: json['explanation'] as String?,
      hdurl: json['hdurl'] as String?,
      mediaType: $enumDecodeNullable(_$MediaTypeEnumMap, json['media_type']),
      serviceVersion:
          $enumDecodeNullable(_$ServiceVersionEnumMap, json['service_version']),
      title: json['title'] as String?,
      url: json['url'] as String?,
      copyright: json['copyright'] as String?,
    );

Map<String, dynamic> _$PictureOfTheDayModelToJson(
        PictureOfTheDayModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'explanation': instance.explanation,
      'hdurl': instance.hdurl,
      'media_type': _$MediaTypeEnumMap[instance.mediaType],
      'service_version': _$ServiceVersionEnumMap[instance.serviceVersion],
      'title': instance.title,
      'url': instance.url,
      'copyright': instance.copyright,
    };

const _$MediaTypeEnumMap = {
  MediaType.image: 'image',
  MediaType.video: 'video',
};

const _$ServiceVersionEnumMap = {
  ServiceVersion.v1: 'v1',
};
