import 'package:cosmo_news_to_do/src/features/app/di/app_scope.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/source/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/picture_of_the_day_view_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/view/picture_detail_view.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/widget/picture_of_the_day_item.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/bloc/picture_of_the_day_bloc.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/bloc/picture_of_the_day_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PictureOfTheDayView extends StatefulWidget {
  const PictureOfTheDayView({super.key});

  @override
  State<PictureOfTheDayView> createState() => _PictureOfTheDayViewState();
}

class _PictureOfTheDayViewState extends State<PictureOfTheDayView> {
  @override
  // TODO(injection): repository inject
  Widget build(BuildContext context) => BlocBuilder<PictureOfTheDayBloc, PictureOfTheDayDataState>(
    builder: (context, state) => Scaffold(
      body: BlocConsumer<PictureOfTheDayBloc, PictureOfTheDayDataState>(
        builder: (context, state) => switch (state) {
          PictureOfTheDayDataStateInitial() =>
            const Center(child: CircularProgressIndicator()),
          PictureOfTheDayDataStateError() => Center(
              child: Text(state.message),
            ),
          _ => PictureOfTheDayList(
              picturesOfTheDay: state.pictureOfTheDayResponseData,
            ),
        },
        listener: (context, state) {
          if (state is PictureOfTheDayDataStateError){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Произошла ошибка'),
            ),);
          }
        },
      ),
    ),
  );
}

///Список постов
class PictureOfTheDayList extends StatefulWidget {
  const PictureOfTheDayList({
    super.key,
    required this.picturesOfTheDay,
  });

  final List<PictureOfTheDayModel> picturesOfTheDay;

  @override
  State<PictureOfTheDayList> createState() => _PictureOfTheDayListState();
}

class _PictureOfTheDayListState extends State<PictureOfTheDayList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }
  void _onScroll() {
    final bloc = context.read<PictureOfTheDayBloc>();
    if (bloc.state is PictureOfTheDayDataStateLoading) {
      return;
    }
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      bloc.add(PictureOfTheDayEventLoadMore());
    }
  }

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
  Widget build(BuildContext context) => CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList.builder(
            itemCount: widget.picturesOfTheDay.length,
            itemBuilder: (context, index) {
              final post = widget.picturesOfTheDay[index];
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
          ),
          if (context.read<PictureOfTheDayBloc>().state
              is PictureOfTheDayDataStateLoading)
            const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      );
}
