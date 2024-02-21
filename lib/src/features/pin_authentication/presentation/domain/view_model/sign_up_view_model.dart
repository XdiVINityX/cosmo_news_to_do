import 'package:cosmo_news_to_do/src/features/pin_authentication/presentation/domain/view_model/sign_up_state.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel() : state = const SignUpState$Idle();
  late SignUpState state;

  void onPinChanged(String v, {bool repeat = false}) {
    final value = repeat
        ? '${state.pinInputData.repeatPin}$v'
        : '${state.pinInputData.pin}$v';
    state = SignUpState$Idle(
      pinInputData: state.pinInputData.copyWith(
        pin: repeat ? null : value,
        repeatPin: repeat ? value : null,
      ),
    );
    notifyListeners();
  }

  void changeRepeatMode(bool repeatMode) {
    state = state.copyWith(repeatMode: repeatMode);
    notifyListeners();
  }

  Future<void> signUp() async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      print('SUCCESS');
      state = SignUpState$Success(
        pinInputData: state.pinInputData,
        repeatMode: state.repeatMode,
      );
      notifyListeners();
    } on Object catch (e) {
      state = SignUpState$Error(
        pinInputData: state.pinInputData,
        repeatMode: state.repeatMode,
        message: '$e',
      );
      notifyListeners();
    }
  }
}
