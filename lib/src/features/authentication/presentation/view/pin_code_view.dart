import 'package:flutter/material.dart';

class PinCodeView extends StatefulWidget {
  const PinCodeView({super.key});

  @override
  State<PinCodeView> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeView> {
  late String pin;


  @override
  void initState() {
    super.initState();
    pin = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// аккуратнее с такими большими хардкодными размерами
            /// Стоит обратить внимание на Expanded виджет,
            /// а также FractionallySizedBox и подобные
            const SizedBox(height: 100),
            const TextPinWidget(),
            const SizedBox(height: 30),
            const PinCodeArea(),
            const SizedBox(height: 200),
             NumberPad(onNumberPressed: _onButtonClick),
          ],
        ),
      ),
    );
  }


  void _onButtonClick(String number) {
    setState(() {
      if (pin.length < 4) {
        pin += number;
      }
    });
  }
}

class TextPinWidget extends StatelessWidget {
  const TextPinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Введите пин код:',
      style: TextStyle(fontSize: 24),
    );
  }
}


class PinCodeArea extends StatelessWidget {
  const PinCodeArea({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          decoration: BoxDecoration(color: const Color(0xFF808080), borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(5),
          width: 20,
          height: 20,
        );
      }),
    );
  }
}

class NumberPad extends StatelessWidget {
  final Function(String) onNumberPressed;
  const NumberPad({Key? key, required this.onNumberPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Expanded(
        child: GridView.count(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(9, (index) {
            var indexInc = index + 1;
            return ButtonNumber(number: indexInc.toString(), onPressed: onNumberPressed);
          }),
        ),
      ),
    );
  }
}

class ButtonNumber extends StatelessWidget {
  final String number;
  final Function(String) onPressed;
  const ButtonNumber({Key? key, required this.number, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style:TextButton.styleFrom(backgroundColor: const Color(0xFFE0DDDD)),
      onPressed: () => onPressed(number),
      child: Text(number, style: const TextStyle(fontSize: 24, color: Color(0xFF000000))),
    );
  }

}