import 'package:flutter/material.dart';

class PictureDetailView extends StatelessWidget {
  const PictureDetailView({super.key, this.date, this.url, this.explanation});

  final DateTime? date;
  final String? url;
  final String? explanation;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: Navigator.of(context).pop,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Hero(
              tag: url!,
              child: Image.network(url!),
            ),
          ),
        ),
      );
}
