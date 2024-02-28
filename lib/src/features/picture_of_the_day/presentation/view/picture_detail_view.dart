import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/entity/picture_of_the_day_model.dart';
import 'package:flutter/material.dart';

class PictureDetailView extends StatefulWidget {
  const PictureDetailView({super.key, required this.post});

  final PictureOfTheDayModel post;

  @override
  State<PictureDetailView> createState() => _PictureDetailViewState();
}

class _PictureDetailViewState extends State<PictureDetailView> {
  @override
  Widget build(BuildContext context) =>  Scaffold(
    backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: widget.post.url!,
          child: Image.network(widget.post.url!),
        ),
      ),
    );
}
