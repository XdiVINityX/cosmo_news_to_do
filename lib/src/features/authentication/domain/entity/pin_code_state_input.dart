class PinCodeStateInput {
  PinCodeStateInput()
      : isFirstTry = true,
        pinInput = '',
        pinInputRepeat = '';

  String pinInput;
  String pinInputRepeat;
  bool isFirstTry;

  bool bothPinsEntered(int pinLength) =>
      pinInput.length == pinLength && pinInputRepeat.length == pinLength;
}
