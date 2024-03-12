import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PictureOfTheDayItem extends StatefulWidget {
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
  State<PictureOfTheDayItem> createState() => _PictureOfTheDayItemState();
}

class _PictureOfTheDayItemState extends State<PictureOfTheDayItem> {
  late DateFormat dateFormatter;

  @override
  void initState() {
    super.initState();
    dateFormatter = DateFormat('yyyy-MM-dd');
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final  isYouTubeVideo = widget.url?.contains('youtube.com') ?? false;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4,2,4,2),
      child: Card(
          child: Column(
            children: [
              if (widget.date != null)
                Text(
                  dateFormatter.format(widget.date!),
                  style: const TextStyle(fontSize: 16,),
                ),
              if(widget.url != null && !isYouTubeVideo)
              HeroImage(
                url: widget.url!,
                onTap: widget.onTap,
              ),
              if (widget.explanation != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,8,0),
                  child: Text(
                    widget.explanation!,
                    style: const TextStyle(fontSize: 18),
                    maxLines: isExpanded ? null : 6,
                  ),
                ),
              if (widget.explanation != null)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8,0,0,2),
                        child: Text(
                          textAlign: TextAlign.left,
                          isExpanded ? 'Скрыть' : 'Показать полностью',
                          style: const TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    super.key,
    required this.url,
    required this.onTap,
  });

  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: url,
          child: FadeInImage.assetNetwork(
            height: 250,
            fit: BoxFit.contain,
            placeholder:'' ,
            placeholderErrorBuilder: (context, error, stackTrace) =>
                const FlutterLogo(),
            image: url,
          ),
        ),
      );
}
