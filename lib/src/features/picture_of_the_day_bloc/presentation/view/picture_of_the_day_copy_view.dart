import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/view/picture_detail_view.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/widget/picture_of_the_day_item.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/bloc/picture_of_the_day_bloc.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/bloc/picture_of_the_day_bloc_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PictureOfTheDayCopyView extends StatefulWidget {
  const PictureOfTheDayCopyView({super.key});

  @override
  State<PictureOfTheDayCopyView> createState() =>
      _PictureOfTheDayCopyViewState();
}

class _PictureOfTheDayCopyViewState extends State<PictureOfTheDayCopyView> {
  @override
  // TODO(injection): repository inject
  Widget build(BuildContext context) =>
      BlocBuilder<PictureOfTheDayBloc, PictureOfTheDayBlocDataState>(
        builder: (context, state) => Scaffold(
          body: BlocConsumer<PictureOfTheDayBloc, PictureOfTheDayBlocDataState>(
            builder: (context, state) => switch (state) {
              PictureOfTheDayBlocDataStateInitial() =>
                const Center(child: CircularProgressIndicator()),
              PictureOfTheDayBlocDataStateError() => Center(
                  child: Text(state.message),
                ),
              _ => PictureOfTheDayList(
                  picturesOfTheDay: state.pictureOfTheDayResponseData,
                ),
            },
            listener: (context, state) {
              if (state is PictureOfTheDayBlocDataStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Произошла ошибка'),
                  ),
                );
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
    if (bloc.state is PictureOfTheDayBlocDataStateLoading) {
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
              is PictureOfTheDayBlocDataStateLoading)
            const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      );
}
