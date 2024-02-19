import 'package:cosmo_news_to_do/src/features/authentication/presentation/state/authentication_state.dart';
import 'package:cosmo_news_to_do/src/features/authentication/presentation/view_model/pin_code_view_model.dart';
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

  void _pinCodeStateListener(PinState state) {
    if (state is Authenticated) {
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
        child: StreamBuilder<PinState>(
          stream: viewModel.pinCodeStateStream,
          initialData: Loading(),
          builder: (context, snapshot) => switch (snapshot.data) {
            Loading() => const Center(
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
          /*{
            if (snapshot.data is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data is Success) {
              return const Column(
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
              );
            }
            if (snapshot.data is Authenticated) {
            //выполнится после завершения текущей  отрисовки
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>
                      ChangeNotifierProvider(create: (_) => TodoListViewModel(),child:const TodoListScreen())),
                );
              });
            }
            return const CircularProgressIndicator();
          },*/
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

class PinCodeArea extends StatelessWidget {
  const PinCodeArea({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PinCodeViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          decoration: BoxDecoration(
            color: viewModel.setColor(index),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(5),
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

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
          var number = index + 1;
          if (number <= 9) {
            return ButtonNumber(number: number.toString());
          }
          switch (number) {
            case 10:
              return const SizedBox();
            case 11:
              return ButtonNumber(number: 0.toString());
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

class ButtonNumber extends StatelessWidget {
  const ButtonNumber({super.key, required this.number});
  final String number;

  Future<void> _onButtonTap(BuildContext context) async {
    final vm = context.read<PinCodeViewModel>();
    await vm.onButtonNumberClick(number);
  }

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(backgroundColor: const Color(0xFFE0DDDD)),
        onPressed: () => _onButtonTap(context),
        child: Text(
          number,
          style: const TextStyle(fontSize: 24, color: Color(0xFF000000)),
        ),
      );
}
