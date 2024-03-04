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
  Widget build(BuildContext context) => Card(
        child: Column(
          children: [
            if (widget.date != null)
              Text(
                dateFormatter.format(widget.date!),
                style: const TextStyle(fontSize: 16),
              ),
            HeroImage(
              url: widget.url,
              onTap: widget.onTap,
            ),
            if (widget.explanation != null)
              Text(
                widget.explanation!,
                style: const TextStyle(fontSize: 18),
                maxLines: isExpanded ? null : 6,
              ),
            if (widget.explanation != null)
            Row(
              children: [GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },

                child: Text(
                  textAlign: TextAlign.left,
                    isExpanded ? 'Скрыть' : 'Показать полностью',
                    style: const TextStyle(fontSize: 18,color: Colors.blue),
                  ),
              ),
              ],
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
            height: 250,
            fit: BoxFit.contain,
            placeholder: 'assets',
            placeholderErrorBuilder: (context, error, stackTrace) =>
                const FlutterLogo(),
            // TODO(add): если url - null, то ссылка будет на пустой ассет
            image: url!,
          ),
        ),
      );
}
