import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/source/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PictureOfTheDayRepo {
  const PictureOfTheDayRepo({
    required this.pictureOfTheDayApiProvider,
  });

  final PictureOfTheDayApiProvider pictureOfTheDayApiProvider;

  Future<List<PictureOfTheDayModel>> getPictures() async {
    try {
      final picturesMap = await pictureOfTheDayApiProvider

          // TODO(fix): Hard date????
          .getPictures(DateTime.now().copyWith(month: 1));
      final pictures = picturesMap.map(PictureOfTheDayModel.fromJson).toList();
      return pictures;
    } on FormatException catch (e, s) {
      Error.throwWithStackTrace(
        Exception('Failed to parse picture of the day: $e'),
        s,
      );
    } on Object {
      rethrow;
    }
  }
}
