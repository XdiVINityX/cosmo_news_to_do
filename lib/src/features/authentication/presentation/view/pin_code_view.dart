import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/source/local/pin_secure_storage.dart';

class PinCodeViewModel extends ChangeNotifier {
  late PinSecureStorage _pinSecureStorage;
  late String? _pin;
  late bool havePin;
  String pinInput = '';


  PinCodeViewModel() {
    init();
  }

  Future<void> init() async {
    _pinSecureStorage = const PinSecureStorage();
    _pin = await _pinSecureStorage.getPinCode();
    havePin = _pin != null;
  }


  void onButtonNumberClick(String number) {
    if (pinInput.length < 4) {
      pinInput += number;
      log('pinAdd = $pinInput');
      notifyListeners();
    }
  }

  void onButtonDeleteClick() {
    if (pinInput.isNotEmpty) {
      pinInput = pinInput.substring(0,pinInput.length - 1);
      log('pinDelete = $pinInput');
    }
    notifyListeners();
  }

  Color setColor(int index) {
    if (pinInput.length >= index + 1 && pinInput.isNotEmpty) {
      return const Color(0xFF54BEA2);
    }
    return const Color(0xFF808080);
  }

//TODO(add)
/// Получить пин код
/// если он пустой, то в текст поставить 'Придумайте пин код'
/// Пользователь вводит его, появляется надпись 'Повторите пин код'
/// Если все верно, пускаем на следующий экран
/// если не пустой, то надпись введите пин код, при верном пускаем, при неверном высвечивается
/// 'Неверно, попробуйте еще раз'

}


class PinCodeView extends StatefulWidget {

  @override
  State<PinCodeView> createState() => _PinCodeWidgetState();
  const PinCodeView({super.key});
}

class _PinCodeWidgetState extends State<PinCodeView> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            TextPinWidget(),
            SizedBox(height: 10),
            PinCodeArea(),
            Spacer(),
            NumberPad(),
            SizedBox(height: 40)
          ],
        ),
      ),
    );
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

 const PinCodeArea({super.key });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PinCodeViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          decoration: BoxDecoration(
              color: viewModel.setColor(index),
              borderRadius: BorderRadius.circular(10)
          ),
          margin: const EdgeInsets.all(5),
          width: 20,
          height: 20,
        );
      }),
    );
  }
}

class NumberPad extends StatelessWidget {

  const NumberPad({super.key,});

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
        itemBuilder:(context, index){
          var number = index + 1;
          if (number <= 9){
            return ButtonNumber(number: number.toString());
          }
          switch(number){
            case 10 : return const SizedBox();
            case 11 : return ButtonNumber(number: 0.toString());
            case 12 : return IconButton(
                icon: const Icon(Icons.backspace),
                onPressed: () => viewModel.onButtonDeleteClick()
            );
          }
          return null;
        },
      ),
    );
  }
}

class ButtonNumber extends StatelessWidget {
  final String number;
  const ButtonNumber({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PinCodeViewModel>();
    return TextButton(
      style:TextButton.styleFrom(backgroundColor: const Color(0xFFE0DDDD)),
      onPressed: () => viewModel.onButtonNumberClick(number),
      child: Text(number, style: const TextStyle(fontSize: 24, color: Color(0xFF000000))),
    );
  }
}



