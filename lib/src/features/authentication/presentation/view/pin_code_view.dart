import 'dart:developer';

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
            const Spacer(),
            const TextPinWidget(),
            const SizedBox(height: 10),
            PinCodeArea(pinLength: pin.length,setColor: _setColor),
            const Spacer(),
            NumberPad(
                onNumberPressed: _onButtonNumberClick,
                onDeletePressed: _onButtonDeleteClick
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  void _onButtonNumberClick(String number) {
    setState(() {
      if (pin.length < 4) {
        pin += number;
        log('pinAdd = $pin');
      }
      //TODO(add)  if number == 4 compare SecureStorage
    });
  }

   void _onButtonDeleteClick() {
     setState(() {
       if (pin.isNotEmpty) {
         pin = pin.substring(0,pin.length - 1);
         log('pinDelete = $pin');
       }
     });
   }

   Color _setColor(int index) {
    if (pin.length >= index + 1 && pin.isNotEmpty) {
      return const Color(0xFF54BEA2);
    }
    return const Color(0xFF808080);
  }

}

class TextPinWidget extends StatelessWidget {
  const TextPinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Введите пин код:',
      style: TextStyle(fontSize: 24),
    );
  }
}

class PinCodeArea extends StatelessWidget {
  final Function(int) setColor;
  final int pinLength;

  const PinCodeArea({super.key,
    required this.pinLength, required this.setColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          decoration: BoxDecoration(color:
          setColor(index), borderRadius: BorderRadius.circular(10)),
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
  final Function() onDeletePressed;
  const NumberPad({super.key, required this.onNumberPressed, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.55,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 3,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 12,
        itemBuilder:(context, index){
          var number = index + 1;
          if (number <= 9){
            return ButtonNumber(number: number.toString(), onPressed: onNumberPressed);
          }
          switch(number){
            case 10 : return const Spacer();
            case 11 : return ButtonNumber(number: 0.toString(), onPressed: onNumberPressed);
            case 12 : return IconButton(icon: const Icon(Icons.backspace),onPressed: onDeletePressed);
          }
          return null;
        },
      ),
    );
  }
}

class ButtonNumber extends StatelessWidget {
  final String number;
  final Function(String) onPressed;
  const ButtonNumber({super.key, required this.number, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style:TextButton.styleFrom(backgroundColor: const Color(0xFFE0DDDD)),
      onPressed: () => onPressed(number),
      child: Text(number, style: const TextStyle(fontSize: 24, color: Color(0xFF000000))),
    );
  }
}



