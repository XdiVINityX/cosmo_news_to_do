import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/bloc/picture_of_the_day_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PictureOfTheDayBloc
    extends Bloc<PictureOfTheDayEvent, PictureOfTheDayDataState> {
  PictureOfTheDayBloc(this.repository)
      : super(
    PictureOfTheDayDataStateInitial(
      dateTimeRange: DateTimeRange(
        start: DateTime.now().add(const Duration(days: -7)),
        end: DateTime.now(),
      ),
    ),
  ) {
    //функции которые реагируют на ивенты
    on<PictureOfTheDayEvent>(
          (event, emitter) =>
      switch (event) {
        final PictureOfTheDayEventLoadInitial event => _onLoadInitialPictureEvent(event,emitter),
        final PictureOfTheDayEventLoadMore event =>  _onLoadMorePictureEvent(event,emitter),
      },
    );
  }

  PictureOfTheDayRepo repository;

  Future<void> _onLoadInitialPictureEvent(PictureOfTheDayEventLoadInitial event,
      Emitter<PictureOfTheDayDataState> emitter,) async {
    try {
     await repository.getPictures(startDate: state.dateTimeRange.start, endDate: state.dateTimeRange.end);

    } on Object {
      emitter(
        PictureOfTheDayDataStateError(
          dateTimeRange: state.dateTimeRange,
          message: 'Что-то пошло не так',
          pictureOfTheDayResponseData: state.pictureOfTheDayResponseData,
        ),
      );
    }
  }

  Future<void> _onLoadMorePictureEvent(PictureOfTheDayEventLoadMore event,
      Emitter<PictureOfTheDayDataState> emitter,) async {
    try {
      const duration = Duration(days: -8);
      final nextDtRange = DateTimeRange(
        start: state.dateTimeRange.start.add(duration),
        end: state.dateTimeRange.end.add(duration),
      );
      final data = await repository.getPictures(startDate: state.dateTimeRange.start, endDate: state.dateTimeRange.end);
      emitter(PictureOfTheDayDataStateSuccess(dateTimeRange: nextDtRange, pictureOfTheDayResponseData: data));
    } on Object {
      emitter(
        PictureOfTheDayDataStateError(
          dateTimeRange: state.dateTimeRange,
          message: 'Что-то пошло не так',
          pictureOfTheDayResponseData: state.pictureOfTheDayResponseData,
        ),
      );
    }
  }
}

sealed class PictureOfTheDayEvent {}

class PictureOfTheDayEventLoadInitial implements PictureOfTheDayEvent {}

class PictureOfTheDayEventLoadMore implements PictureOfTheDayEvent {}
