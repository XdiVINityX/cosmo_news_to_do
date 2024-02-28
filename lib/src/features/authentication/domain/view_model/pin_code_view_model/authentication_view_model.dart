import 'dart:async';
import 'dart:developer';
import 'package:cosmo_news_to_do/src/features/authentication/data/repository/authentication_repository.dart';
import 'package:cosmo_news_to_do/src/features/authentication/domain/entity/pin_code_state_input.dart';
import 'package:cosmo_news_to_do/src/features/authentication/domain/interface/pin_code_secure_storage_repository.dart';
import 'package:cosmo_news_to_do/src/features/authentication/presentation/state/authentication_state.dart';
import 'package:flutter/foundation.dart';



class AuthenticationViewModel extends ChangeNotifier {
  AuthenticationViewModel() {
    _pinCodeStateStreamController =
        StreamController<AuthenticationState>.broadcast();
    init();
  }

  late final PinCodeStateInput _pinCodeStateInput;
  late StreamController<AuthenticationState> _pinCodeStateStreamController;
  Stream<AuthenticationState> get pinCodeStateStream =>
      _pinCodeStateStreamController.stream;
  late final PinSecureStorageRepository _pinRepository;
  late String? _pinFromStorage;
  late bool _havePinFromStorage;

  Future<void> init() async {
    _updateState(const PinCodeLoading());
    _pinCodeStateInput = PinCodeStateInput();
    _pinRepository = AuthenticationRepository();
    // await _pinSecureStorageRepo.deletePinCode();
    _pinFromStorage = await _pinRepository.getPinCode();
    _havePinFromStorage = _pinFromStorage != null;
    _updateState(PinCodeLoaded(pinCodeState: _pinCodeStateInput));
  }

  @override
  void dispose() {
    super.dispose();
    _pinCodeStateStreamController.close();
  }

  void _updateState(AuthenticationState pinState) {
    _pinCodeStateStreamController.add(pinState);
  }

  Future<void> onButtonNumberClick(String number) async {
    if (_havePinFromStorage) {
      _handleHavePin(number);
    } else {
      await _handleNoPin(number);
      _updateState(PinCodeChangedInput(pinCodeState: _pinCodeStateInput));
    }
  }

  void onButtonDeleteClick() {
    if (_pinCodeStateInput.pinInputRepeat.isNotEmpty) {
      _pinCodeStateInput.pinInputRepeat = _pinCodeStateInput.pinInputRepeat
          .substring(0, _pinCodeStateInput.pinInputRepeat.length - 1);
      log('pinInputRepeat in viewModel = ${_pinCodeStateInput.pinInputRepeat}');
      _updateState(PinCodeChangedInput(pinCodeState: _pinCodeStateInput));
    } else {
      if (_pinCodeStateInput.pinInput.isNotEmpty) {
        _pinCodeStateInput.pinInput = _pinCodeStateInput.pinInput
            .substring(0, _pinCodeStateInput.pinInput.length - 1);
        log('pinInput in viewModel = ${_pinCodeStateInput.pinInput}');
        _updateState(PinCodeChangedInput(pinCodeState: _pinCodeStateInput));
      }
    }
    notifyListeners();
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
    if (_pinCodeStateInput.bothPinsEntered(4)) {
      await _checkCodes();
    }
  }

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
    if (_havePinFromStorage &&
        (_pinCodeStateInput.pinInput.length == 4) &&
        _pinFromStorage == _pinCodeStateInput.pinInput) {
      _updateState(PinCodeAuthenticated());
    }
    if (_havePinFromStorage &&
        (_pinCodeStateInput.pinInput.length == 4) &&
        _pinFromStorage != _pinCodeStateInput.pinInput) {
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
      _updateState(const PinCodeLoading());
      await _pinRepository
          .savePinCode(_pinCodeStateInput.pinInputRepeat);
      _updateState(PinCodeAuthenticated());
    } on Object {
      _updateState(
        const PinCodeError(message: 'Не удалось сохранить пин код'),
      );

      rethrow;
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
    _pinCodeStateInput
      ..pinInput = ''
      ..pinInputRepeat = '';
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
