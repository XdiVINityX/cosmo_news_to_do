// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture_of_the_day_copy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PictureOfTheDayCopyModelImpl _$$PictureOfTheDayCopyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PictureOfTheDayCopyModelImpl(
      date: DateTime.parse(json['date'] as String),
      explanation: json['explanation'] as String,
      hdUrl: json['hdurl'] as String?,
      mediaType: json['media_type'] as String,
      serviceVersion: json['service_version'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      copyright: json['copyright'] as String?,
    );

Map<String, dynamic> _$$PictureOfTheDayCopyModelImplToJson(
        _$PictureOfTheDayCopyModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'explanation': instance.explanation,
      'hdurl': instance.hdUrl,
      'media_type': instance.mediaType,
      'service_version': instance.serviceVersion,
      'title': instance.title,
      'url': instance.url,
      'copyright': instance.copyright,
    };
