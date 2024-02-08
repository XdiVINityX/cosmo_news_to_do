import 'package:flutter/material.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeScreen> {
  String pin = '';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

  Widget _textPin(){
    return const Center(
        child: Text('Введите пин код:',
          style: TextStyle(fontSize: 24),)
    );
  }

  Widget _pinCodeArea(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      List.generate(4, (index) {
        return Container(
          decoration:BoxDecoration(
              color: const Color(0xFF808080),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(5),
          width: 20,
          height: 20,
        );
      },),
    );
  }


  Widget _numberPad() {
    return  SizedBox(
      width: 250,
      height: 250,
      child: Expanded(
        child: Center(
          child: GridView.count(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            children:  List.generate(9,(index) {
                  var indexInc = index+1;
                return _buttonNumber(indexInc.toString());
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonClick(String number){
    setState(() {
      if(pin.length < 4){
        pin += number;
      }
    });
  }

  Widget _buttonNumber(String number) {
    return TextButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color(
          0xFFE0DDDD))
      ),
      onPressed: () {
        _onButtonClick(number);
      },
      child: Text(number,
          style: const TextStyle(
              fontSize: 24,
              color: Color(0xFF000000))),
    );
  }
}






