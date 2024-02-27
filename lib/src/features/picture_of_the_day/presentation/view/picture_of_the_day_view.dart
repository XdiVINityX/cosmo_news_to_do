import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/data_state_picture_of_the_day.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PictureOfTheDayView extends StatefulWidget {
  const PictureOfTheDayView({super.key});

  @override
  State<PictureOfTheDayView> createState() => _PictureOfTheDayViewState();
}

class _PictureOfTheDayViewState extends State<PictureOfTheDayView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PictureOfTheDayViewModel>();
    return SafeArea(
      child: Scaffold(
        body: ListViewPictureOfTheDay(
          data: viewModel.dataListObj,
        ),
      ),
    );
  }
}

// TODO(improve): посты определенного размера, скрытие лишнего текта
class ListViewPictureOfTheDay extends StatelessWidget {
  const ListViewPictureOfTheDay({
    super.key,
    required this.data,
  });

  final List<PictureOfTheDayModel> data;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PictureOfTheDayViewModel>();
    if (viewModel.state is PictureOfTheDayDataStateLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return Card(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(post.date.toString(), style: const TextStyle(fontSize: 16)),
              Image.network(post.url!),
              Text(post.explanation!, style: const TextStyle(fontSize: 18)),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}