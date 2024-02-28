import 'package:cosmo_news_to_do/src/features/authentication/domain/entity/pin_code_state_input.dart';

sealed class AuthenticationState {}

class PinCodeLoading implements AuthenticationState {
  const PinCodeLoading({
    this.pinCodeState,
  });
  final PinCodeStateInput? pinCodeState;
}

class PinCodeLoaded implements AuthenticationState {
  const PinCodeLoaded({
    this.pinCodeState,
  });

  final PinCodeStateInput? pinCodeState;
}
class PinCodeChangedInput implements AuthenticationState{
  const PinCodeChangedInput({
    required this.pinCodeState,
  });

  final PinCodeStateInput pinCodeState;
}

class PinCodeAuthenticated implements AuthenticationState {}

class PinCodeAuthError implements AuthenticationState {}

class PinCodeError implements AuthenticationState {
  const PinCodeError({
    required this.message,
  });
  final String message;
}
