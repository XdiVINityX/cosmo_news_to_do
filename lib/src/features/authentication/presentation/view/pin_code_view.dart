import 'dart:developer';
import 'package:cosmo_news_to_do/src/features/authentication/presentation/state/authentication_state.dart';
import 'package:cosmo_news_to_do/src/features/authentication/presentation/view_model/pin_code_view_model.dart';
import 'package:cosmo_news_to_do/src/features/authentication/presentation/widget/number_pad.dart';
import 'package:cosmo_news_to_do/src/features/todo_list/presentation/view/todo_list_view.dart';
import 'package:cosmo_news_to_do/src/features/todo_list/presentation/view_model/todo_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinCodeView extends StatefulWidget {
  const PinCodeView({super.key});

  @override
  State<PinCodeView> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeView> {
  @override
  void initState() {
    super.initState();
    context
        .read<PinCodeViewModel>()
        .pinCodeStateStream
        .listen(_pinCodeStateListener);
  }

  void _pinCodeStateListener(AuthenticationState state) {
    if (state is PinCodeAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<dynamic>(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => TodoListViewModel(),
            child: const TodoListScreen(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PinCodeViewModel>();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<AuthenticationState>(
          stream: viewModel.pinCodeStateStream,
          initialData: const PinCodeLoading(),
          builder: (context, snapshot) => switch (snapshot.data) {
            PinCodeLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            _ => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  TextPinWidget(),
                  SizedBox(height: 10),
                  PinCodeArea(),
                  Spacer(),
                  NumberPad(),
                  SizedBox(height: 40),
                ],
              ),
          },
        ),
      ),
    );
  }
}

class TextPinWidget extends StatelessWidget {
  const TextPinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PinCodeViewModel>();
    return Text(
      viewModel.setText(),
      style: const TextStyle(fontSize: 24),
    );
  }
}

class PinCodeArea extends StatefulWidget {
  const PinCodeArea({super.key});

  @override
  State<PinCodeArea> createState() => _PinCodeAreaState();
}

class _PinCodeAreaState extends State<PinCodeArea> {
  _PinCodeAreaState() : pinCodeStateInput = PinCodeStateInput();
  late PinCodeStateInput pinCodeStateInput;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PinCodeViewModel>();
    viewModel.pinCodeStateStream.listen(_pinCodeStateListener);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          decoration: BoxDecoration(
            color: setColor(index), //viewModel.setColor(index),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(5),
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  void _pinCodeStateListener(AuthenticationState state) {
    if (state is PinCodeChangedInput) {
      pinCodeStateInput
        ..pinInput = state.pinCodeState.pinInput
        ..pinInputRepeat = state.pinCodeState.pinInputRepeat;
    }
  }

  Color setColor(int index) {
    log('pinInput = ${pinCodeStateInput.pinInput}');
    if (pinCodeStateInput.pinInput.length == 4) {
      if (pinCodeStateInput.pinInputRepeat.length >= index + 1 &&
          pinCodeStateInput.pinInputRepeat.isNotEmpty) {
        return const Color(0xFF188077);
      }
      return const Color(0xFF808080);
    }
    if (pinCodeStateInput.pinInput.length >= index + 1 &&
        pinCodeStateInput.pinInput.isNotEmpty) {
      return const Color(0xFF54BEA2);
    }
    return const Color(0xFF808080);
  }
}
