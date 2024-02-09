import 'package:flutter/material.dart';

class PinCodeView extends StatefulWidget {
  const PinCodeView({super.key});

  @override
  State<PinCodeView> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeView> {
  /// Практика присваивать дефолтно значение при инициализации- плохая
  /// Либо мы передаем значение из того места, в котором идет вызов
  /// (если это оправдано)
  /// либо инициализируем подобным образом в initState
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
            _textPin(),
            const SizedBox(height: 30),
            _pinCodeArea(),
            const SizedBox(height: 200),
            _numberPad(),
          ],
        ),
      ),
    );
  }

  /// Плохая практика создавать виджеты в виде функций,
  /// так как каждый раз при перестроении build метода будет обязательно
  /// вызов метода (итого получаем огромное количество ребилдов)
  /// Такое опарвадано для тех виджетов, которые должны перестраиваться при любом
  /// чихе, либо они точно не будут перестраиваться и являются полностью статичными
  /// *имеется ввиду родитель
  /// Для тестирования можно открыть devTools и включить режим отображения
  /// рамки виджетов, которая будет каждый раз менять цвет при перестроении
  Widget _textPin() {
    /// точно ли мы не можем выровнять текст параметрами родителя
    /// например crossAxisAlignment и mainAxisSize у Column
    return const Center(
        child: Text(
      'Введите пин код:',
      style: TextStyle(fontSize: 24),
    ));
  }

  Widget _pinCodeArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) {
          return Container(
            decoration: BoxDecoration(
                color: const Color(0xFF808080),
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(5),
            width: 20,
            height: 20,
          );
        },
      ),
    );
  }

  Widget _numberPad() {
    return SizedBox(
      width: 250,
      height: 250,
      child: Expanded(
        child: Center(
          child: GridView.count(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              9,
              (index) {
                /// кажется 0 я не смогу использовать в pin-code =(
                var indexInc = index + 1;
                return _buttonNumber(indexInc.toString());
              },
            ),
          ),
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

  Widget _buttonNumber(String number) {
    return TextButton(
      /// у большого кол-ва подобных виджетов есть уже заложенная тема
      /// без необходимости обозначать MaterialStateProperty
      // style: TextButton.styleFrom(backgroundColor: Color(0xFFE0DDDD)),
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFE0DDDD))),

      /// Предпочтительно использовать expression body
      /// *за то что вынес сам метод "ПЛЮС"- это отлично!
      // onPressed: () => _onButtonClick(number),
      onPressed: () {
        _onButtonClick(number);
      },
      child: Text(number,
          style: const TextStyle(fontSize: 24, color: Color(0xFF000000))),
    );
  }
}
