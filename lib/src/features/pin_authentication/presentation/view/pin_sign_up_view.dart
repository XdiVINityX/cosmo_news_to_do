import 'package:cosmo_news_to_do/src/features/pin_authentication/presentation/domain/view_model/sign_up_view_model.dart';
import 'package:cosmo_news_to_do/src/features/pin_authentication/presentation/widget/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinSignUpView extends StatefulWidget {
  const PinSignUpView({super.key});

  @override
  State<PinSignUpView> createState() => _PinSignUpViewState();
}

class _PinSignUpViewState extends State<PinSignUpView> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => SignUpViewModel(),
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AuthenticationHeader('Придумайте пин-код'),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<SignUpViewModel>(
                        builder: (BuildContext context, value, Widget? child) =>
                            PinInputWidget(
                          pinInput: value.state.pinInputData.pin,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: NumberPad(
                    onChanged: context.read<SignUpViewModel>().onPinChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
