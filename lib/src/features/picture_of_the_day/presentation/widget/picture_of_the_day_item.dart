import 'package:flutter/material.dart';

class PictureOfTheDayItem extends StatelessWidget {
  const PictureOfTheDayItem({
    super.key,
    this.date,
    this.url,
    this.explanation,
    required this.onTap,
  });

  final String? url;
  final DateTime? date;
  final String? explanation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          children: [
            if (date != null)
              Text(
                date.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            HeroImage(
              url: url,
              onTap: onTap,
            ),
            if (explanation != null)
              Text(
                explanation!,
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      );
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    super.key,
    this.url,
    required this.onTap,
  });

  final String? url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: url!,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets',
            placeholderErrorBuilder: (context, error, stackTrace) =>
                const FlutterLogo(),
            // TODO(add): если url - null, то ссылка будет на пустой ассет
            image: url!,
          ),
        ),
      );
}
