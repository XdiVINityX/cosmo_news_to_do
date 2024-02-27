import 'package:cosmo_news_to_do/src/features/authentication/presentation/view_model/pin_code_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumberPad extends StatelessWidget {
  const NumberPad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PinCodeViewModel>();
    return FractionallySizedBox(
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
            return _ButtonNumber(
                 onButtonTap: viewModel.onButtonNumberClick,
                number: '$number',
            );
          }
          switch (number) {
            case 10:
              return const SizedBox();
            case 11:
              return _ButtonNumber(
                onButtonTap: viewModel.onButtonNumberClick,
                number: 0.toString(),);
            case 12:
              return IconButton(
                icon: const Icon(Icons.backspace),
                onPressed: viewModel.onButtonDeleteClick,
              );
          }
          return null;
        },
      ),
    );
  }
}

class _ButtonNumber extends StatelessWidget {

  const _ButtonNumber({
    required this.number,
    required this.onButtonTap,
  });

  final String number;
  final void Function(String) onButtonTap;

  @override
  Widget build(BuildContext context) => TextButton(
    style: TextButton.styleFrom(backgroundColor: const Color(0xFFE0DDDD)),
    onPressed: () => onButtonTap(number),
    child: Text(
      number,
      style: const TextStyle(fontSize: 24, color: Color(0xFF000000)),
    ),
  );
}
