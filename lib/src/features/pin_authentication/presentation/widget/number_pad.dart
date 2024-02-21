import 'dart:async';
import 'package:cosmo_news_to_do/src/features/authentication/presentation/view_model/pin_code_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumberPad extends StatelessWidget {
  const NumberPad({
    this.onChanged,
    this.onDelete,
    super.key,
  });

  final ValueChanged<String>? onChanged;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        widthFactor: 0.6,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 3,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 12,
          itemBuilder: (context, index) {
            final number = index + 1;
            if (number <= 9) {
              return ButtonNumber(
                onButtonTap: () => onChanged?.call('$number'),
                number: number.toString(),
              );
            }
            switch (number) {
              case 10:
                return const SizedBox();
              case 11:
                return ButtonNumber(
                  onButtonTap: () => onChanged?.call('$number'),
                  number: 0.toString(),
                );
              case 12:
                return IconButton(
                  icon: const Icon(Icons.backspace),
                  onPressed: onDelete,
                );
            }
            return null;
          },
        ),
      );
}

class ButtonNumber extends StatelessWidget {
  const ButtonNumber({
    super.key,
    required this.number,
    required this.onButtonTap,
  });

  final String number;
  final VoidCallback onButtonTap;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(backgroundColor: const Color(0xFFE0DDDD)),
        onPressed: onButtonTap.call,
        child: Text(
          number,
          style: const TextStyle(fontSize: 24, color: Color(0xFF000000)),
        ),
      );
}
