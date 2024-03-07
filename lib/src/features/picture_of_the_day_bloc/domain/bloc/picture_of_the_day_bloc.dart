import 'package:cosmo_news_to_do/src/core/utils/app_exception.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/data/repository/picture_of_the_day_copy_repository.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/bloc/picture_of_the_day_bloc_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PictureOfTheDayBloc
    extends Bloc<PictureOfTheDayEvent, PictureOfTheDayBlocDataState> {
  PictureOfTheDayBloc(this.repository)
      : super(
          PictureOfTheDayBlocDataStateInitial(
            dateTimeRange: DateTimeRange(
              start: DateTime.now().add(const Duration(days: -7)),
              end: DateTime.now(),
            ),
          ),
        ) {
    //функции которые реагируют на ивенты
    on<PictureOfTheDayEvent>(
      (event, emitter) => switch (event) {
        final PictureOfTheDayEventLoadInitial event =>
          _onLoadInitialPictureEvent(event, emitter),
        final PictureOfTheDayEventLoadMore event =>
          _onLoadMorePictureEvent(event, emitter),
      },
    );
  }

  PictureOfTheDayCopyRepository repository;

  Future<void> _onLoadInitialPictureEvent(
    PictureOfTheDayEventLoadInitial event,
    Emitter<PictureOfTheDayBlocDataState> emitter,
  ) async {
    try {
      final data = await repository.getPictures(
        startDate: state.dateTimeRange.start,
        endDate: state.dateTimeRange.end,
      );
      emitter(
        PictureOfTheDayBlocDataStateSuccess(
          pictureOfTheDayResponseData: data,
          dateTimeRange: state.dateTimeRange,
        ),
      );
    } on AppException catch (e) {
      emitter(
        PictureOfTheDayBlocDataStateError(
          dateTimeRange: state.dateTimeRange,
          message: e.message,
          pictureOfTheDayResponseData: state.pictureOfTheDayResponseData,
        ),
      );
      rethrow;
    }
  }

  Future<void> _onLoadMorePictureEvent(
    PictureOfTheDayEventLoadMore event,
    Emitter<PictureOfTheDayBlocDataState> emitter,
  ) async {
    emitter(
      PictureOfTheDayBlocDataStateLoading(
        dateTimeRange: state.dateTimeRange,
        pictureOfTheDayResponseData: state.pictureOfTheDayResponseData,
      ),
    );
    try {
      final data = await repository.getPictures(
        startDate: state.dateTimeRange.start,
        endDate: state.dateTimeRange.end,
      );
      const duration = Duration(days: -8);
      final nextDtRange = DateTimeRange(
        start: state.dateTimeRange.start.add(duration),
        end: state.dateTimeRange.end.add(duration),
      );
      emitter(
        PictureOfTheDayBlocDataStateSuccess(
          dateTimeRange: nextDtRange,
          pictureOfTheDayResponseData: [
            ...state.pictureOfTheDayResponseData,
            ...data,
          ],
        ),
      );
    } on AppException catch (e) {
      emitter(
        PictureOfTheDayBlocDataStateError(
          dateTimeRange: state.dateTimeRange,
          message: e.message,
          pictureOfTheDayResponseData: state.pictureOfTheDayResponseData,
        ),
      );
      rethrow;
    }
  }
}

sealed class PictureOfTheDayEvent {}

class PictureOfTheDayEventLoadInitial implements PictureOfTheDayEvent {}

class PictureOfTheDayEventLoadMore implements PictureOfTheDayEvent {}
