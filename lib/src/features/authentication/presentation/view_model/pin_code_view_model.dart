import 'dart:async';
import 'dart:developer';
import 'package:cosmo_news_to_do/src/features/authentication/domain/pin_repo.dart';
import 'package:cosmo_news_to_do/src/features/authentication/presentation/state/authentication_state.dart';
import 'package:flutter/cupertino.dart';


class PinCodeStateInput {
  PinCodeStateInput()
      : isFirstTry = true,
        pinInput = '',
        pinInputRepeat = '';

  String pinInput;
  String pinInputRepeat;
  bool isFirstTry;
}

class PinCodeViewModel extends ChangeNotifier {
  PinCodeViewModel() {
    _pinCodeStateStreamController = StreamController<AuthenticationState>.broadcast();
    init();
  }

  late final PinCodeStateInput _pinCodeStateInput;
  late StreamController<AuthenticationState> _pinCodeStateStreamController;
  Stream<AuthenticationState> get pinCodeStateStream =>
      _pinCodeStateStreamController.stream;
  late final PinSecureStorageRepo _pinSecureStorageRepo;
  late String? _pinFromStorage;
  late bool _havePinFromStorage;

  Future<void> init() async {
    updateState(PinCodeLoading());
    _pinCodeStateInput = PinCodeStateInput();
    _pinSecureStorageRepo = PinSecureStorageRepo();
    // await _pinSecureStorageRepo.deletePinCode();
    _pinFromStorage = await _pinSecureStorageRepo.getPinCode();
    _havePinFromStorage = _pinFromStorage != null;
    updateState(PinCodeLoaded(pinCodeState: _pinCodeStateInput));
  }

  @override
  void dispose() {
    super.dispose();
    _pinCodeStateStreamController.close();
  }

  void updateState(AuthenticationState pinState) {
    _pinCodeStateStreamController.add(pinState);
  }

  Future<void> onButtonNumberClick(String number) async {
    if (_havePinFromStorage) {
      _handleHavePin(number);
    } else {
      await _handleNoPin(number);
      updateState(PinCodeChangedInput(pinCodeState: _pinCodeStateInput));
    }
  }

  /// Обработка pin если он уже был задан
  void _handleHavePin(String number) {
    if (_pinCodeStateInput.pinInput.length < 4) {
      _pinCodeStateInput.pinInput += number;
      notifyListeners();
      _comparePins();
    }
  }

  ///Обработка введенного пин кода и повторного
  ///Когда пин код еще не был создан
  FutureOr<void> _handleNoPin(String number) async {
    if (_pinCodeStateInput.pinInput.length < 4) {
      _addToPinInput(number);
    } else if (_pinCodeStateInput.pinInputRepeat.length < 4) {
      _addToPinInputRepeat(number);
    }
    if (_bothPinsEntered()) {
      await _checkCodes();
    }
  }

  bool _bothPinsEntered() => _pinCodeStateInput.pinInput.length == 4 && _pinCodeStateInput.pinInputRepeat.length == 4;

  void _addToPinInput(String number) {
    _pinCodeStateInput.pinInput += number;
    log('pinInput in viewModel = ${_pinCodeStateInput.pinInput}');
    notifyListeners();
  }

  void _addToPinInputRepeat(String number) {
    _pinCodeStateInput.pinInputRepeat += number;
    log('pinInputRepeat in viewModel = ${_pinCodeStateInput.pinInputRepeat}');
    notifyListeners();
  }

  /// сравнение введенного пин кода с сохраненным
  void _comparePins() {
    if (_havePinFromStorage && (_pinCodeStateInput.pinInput.length == 4) && _pinFromStorage == _pinCodeStateInput.pinInput) {
      updateState(PinCodeAuthenticated());
    }
    if (_havePinFromStorage && (_pinCodeStateInput.pinInput.length == 4) && _pinFromStorage != _pinCodeStateInput.pinInput) {
      _handleMismatch();
    }
  }

  /// Оба кода введены, и совпадают, тогда сохраняем
  /// Иначе очищаем
  Future<void> _checkCodes() async {
    if (_pinCodeStateInput.pinInput == _pinCodeStateInput.pinInputRepeat) {
      await _authenticateUser();
    } else {
      _handleMismatch();
    }
  }

  /// Сохраняем введенный пин и обновляем статус
  Future<void> _authenticateUser() async {
    try {
      updateState(const PinCodeLoading());
      await _pinSecureStorageRepo.savePinCode(_pinCodeStateInput.pinInputRepeat);
      updateState(PinCodeAuthenticated());
    } on Object {
      updateState(
        const PinCodeError(message: 'Не удалось сохранить пин код'),
      );
    }
  }

  /// Первичный и вторичный ввод не соответствуют друг другу
  void _handleMismatch() {
    _pinCodeStateInput.isFirstTry = false;
    log('Неудачная попытка = $_pinCodeStateInput.isFirstTry');
    _clear();
    notifyListeners();
  }

  void _clear() {
    log('Ввод очищен = $_pinCodeStateInput.pinInput $_pinCodeStateInput.pinInputRepeat ');
    _pinCodeStateInput..pinInput = ''
    ..pinInputRepeat = '';
  }

  void onButtonDeleteClick() {
    if (_pinCodeStateInput.pinInputRepeat.isNotEmpty) {
      _pinCodeStateInput.pinInputRepeat = _pinCodeStateInput.pinInputRepeat.substring(0, _pinCodeStateInput.pinInputRepeat.length - 1);
      log('pinInputRepeat in viewModel = ${_pinCodeStateInput.pinInputRepeat}');
      updateState(PinCodeChangedInput(pinCodeState: _pinCodeStateInput));
    } else {
      if (_pinCodeStateInput.pinInput.isNotEmpty) {
        _pinCodeStateInput.pinInput = _pinCodeStateInput.pinInput.substring(0, _pinCodeStateInput.pinInput.length - 1);
        log('pinInput in viewModel = ${_pinCodeStateInput.pinInput}');
        updateState(PinCodeChangedInput(pinCodeState: _pinCodeStateInput));
      }
    }
    notifyListeners();
  }

  String setText() {
    if (!_pinCodeStateInput.isFirstTry) {
      _pinCodeStateInput.isFirstTry = true;
      return 'Пин-код не совпадает, повторите';
    }
    if (_havePinFromStorage) {
      return 'Введите пин-код';
    }
    if (_pinCodeStateInput.pinInput.length == 4) {
      return 'Повторите пин-код';
    }
    return 'Придумайте пин-код';
  }
}
