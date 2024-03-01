import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/data_state_picture_of_the_day.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/picture_of_the_day_view_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/view/picture_detail_view.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/widget/picture_of_the_day_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PictureOfTheDayView extends StatefulWidget {
  const PictureOfTheDayView({super.key});

  @override
  State<PictureOfTheDayView> createState() => _PictureOfTheDayViewState();
}

class _PictureOfTheDayViewState extends State<PictureOfTheDayView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Consumer<PictureOfTheDayViewModel>(
          builder: (context, viewModel, child) => switch (viewModel.state) {
            PictureOfTheDayDataStateLoading() =>
              const Center(child: CircularProgressIndicator()),
            final PictureOfTheDayDataStateSuccess s => PictureOfTheDayList(
                picturesOfTheDay: s.pictureOfTheDayResponseData,
              ),
            final PictureOfTheDayDataStateError e => Center(
                child: Text(e.message),
              ),
          },
        ),
      );
}

// TODO(improve): посты определенного размера, скрытие лишнего текта
///Список постов
class PictureOfTheDayList extends StatelessWidget {
  const PictureOfTheDayList({
    super.key,
    required this.picturesOfTheDay,
  });

  final List<PictureOfTheDayModel> picturesOfTheDay;

  void _goToScreen(
    BuildContext context, {
    required String? url,
    required DateTime? date,
    required String? explanation,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (context) => PictureDetailView(
          url: url,
          date: date,
          explanation: explanation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: picturesOfTheDay.length,
        itemBuilder: (context, index) {
          final post = picturesOfTheDay[index];
          return PictureOfTheDayItem(
            url: post.url,
            date: post.date,
            explanation: post.explanation,
            onTap: () => _goToScreen(
              context,
              url: post.url,
              date: post.date,
              explanation: post.explanation,
            ),
          );
        },
      );
}
