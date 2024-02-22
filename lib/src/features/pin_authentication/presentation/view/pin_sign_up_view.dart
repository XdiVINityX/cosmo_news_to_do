import 'package:cosmo_news_to_do/src/features/common/di/change_notifier_provider_wrapper.dart';
import 'package:cosmo_news_to_do/src/features/pin_authentication/presentation/domain/view_model/sign_up_view_model.dart';
import 'package:cosmo_news_to_do/src/features/pin_authentication/presentation/widget/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinSignUpView extends StatelessWidget {
  const PinSignUpView({super.key});

  void _onPinChanged(BuildContext context, String v, {bool remove = false}) {
    context.read<SignUpViewModel>().onPinChanged(v, remove: remove);
  }

  void _onComplete(BuildContext context) {
    context.read<SignUpViewModel>().changeRepeatMode();
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProviderWrapper<SignUpViewModel>(
        provider: SignUpViewModel(),
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<SignUpViewModel>(
                      builder: (context, vm, __) => AuthenticationHeader(
                        vm.state.repeatMode ? 'Repeat PIN' : 'Create PIN',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<SignUpViewModel>(
                      builder: (BuildContext context, vm, Widget? child) =>
                          PinInputWidget(
                        pinInput: vm.state.repeatMode
                            ? vm.state.pinInputData.repeatPin
                            : vm.state.pinInputData.pin,
                        onComplete: () => _onComplete(context),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NumberPad(
                  onChanged: (v) => _onPinChanged(context, v),
                  onDelete: () => _onPinChanged(context, '', remove: true),
                ),
              ),
            ],
          ),
        ),
      );
}
