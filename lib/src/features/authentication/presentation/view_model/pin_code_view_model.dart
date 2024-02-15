import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../domain/pin_secure_storage_repo.dart';
import '../state/authentication_state.dart';

class PinCodeViewModel extends ChangeNotifier {

  late StreamController<PinState> _pinCodeStateStreamController;
  Stream<PinState> get pinCodeStateStream => _pinCodeStateStreamController.stream;

  late String pinInput;
  late String pinInputRepeat;
  late bool _isFirstTry;
  late PinSecureStorageRepo _pinSecureStorageRepo;
  late String? _pin;
  late bool havePin;

  PinCodeViewModel() {
    _pinCodeStateStreamController = StreamController<PinState>.broadcast();
    init();
  }

  Future<void> init() async {
    updateState(Loading());
    pinInput = '';
    pinInputRepeat = '';
    _isFirstTry = true;
    _pinSecureStorageRepo = PinSecureStorageRepo();
    _pin = await _pinSecureStorageRepo.getPinCode();
    havePin = _pin != null;
    updateState(Success());
  }

  @override
  void dispose() {
    super.dispose();
    _pinCodeStateStreamController.close();
  }

  void updateState(PinState pinState){
    _pinCodeStateStreamController.add(pinState);
  }

  void onButtonNumberClick(String number) {
    if(havePin){
       _handleHavePin(number);
    } else{
      _handleNoPin(number);
    }
  }

  /// Обработка pin если он уже был задан
  void _handleHavePin(String number) {
    if (pinInput.length < 4) {
      pinInput += number;
      notifyListeners();
      _comparePins();
    }
  }

  ///Обработка введенного пин кода и повторного
  ///Когда пин код еще не был создан
  void _handleNoPin(String number) {
    if (pinInput.length < 4) {
      _addToPinInput(number);
    } else if (pinInputRepeat.length < 4){
      _addToPinInputRepeat(number);
    }
    if (_bothPinsEntered()){
      _checkCodes();
    }
  }

  bool _bothPinsEntered() => pinInput.length == 4 && pinInputRepeat.length == 4;

  void _addToPinInput(String number) {
    pinInput += number;
    log('pinInput = $pinInput');
    notifyListeners();
  }

  void _addToPinInputRepeat(String number) {
    pinInputRepeat += number;
    log('pinInputRepeat = $pinInputRepeat');
    notifyListeners();
  }


  /// сравнение введенного пин кода с сохраненным
  void _comparePins(){
    if(havePin && (pinInput.length == 4) && _pin == pinInput){
      updateState(Authenticated());
    }
    if(havePin && (pinInput.length == 4)  && _pin != pinInput ){
      _handleMismatch();
    }
  }

  /// Оба кода введены, и совпадают, тогда сохраняем
  /// Иначе очищаем
  void _checkCodes(){
    if((pinInput == pinInputRepeat)){
      _authenticateUser();
    }
    else {
      _handleMismatch();
    }
  }

  /// Сохраняем введенный пин и обновляем статус
  void _authenticateUser() {
    updateState(Loading());
    _pinSecureStorageRepo.savePinCode(pinInputRepeat);
    updateState(Authenticated());
  }

  /// Первичный и вторичный ввод не соответствуют друг другу
  void _handleMismatch() {
    _isFirstTry = false;
    log('Неудачная попытка = $_isFirstTry');
    _clear();
    notifyListeners();
  }

  void _clear(){
    log('Ввод очищен = $pinInput $pinInputRepeat ');
    pinInput = '';
    pinInputRepeat = '';
  }



  void onButtonDeleteClick() {
    if (pinInputRepeat.isNotEmpty) {
      pinInputRepeat = pinInputRepeat.substring(0,pinInputRepeat.length - 1);
      log('pinInputRepeat = $pinInputRepeat');
    }else{
      if (pinInput.isNotEmpty) {
        pinInput = pinInput.substring(0,pinInput.length - 1);
        log('pinInput = $pinInput');
      }
    }
    notifyListeners();
  }

  Color setColor(int index) {
    if (pinInput.length == 4) {
      if (pinInputRepeat.length >= index + 1 && pinInputRepeat.isNotEmpty) {
        return const Color(0xFF188077);
      }
      return const Color(0xFF808080);
    }
    if (pinInput.length >= index + 1 && pinInput.isNotEmpty) {
      return const Color(0xFF54BEA2);
    }
    return const Color(0xFF808080);
  }

  String setText() {
    if (!_isFirstTry) {
      _isFirstTry = true;
      return 'Пин-код не совпадает, повторите';
    }
    if (havePin) {
      return 'Введите пин-код';
    }
    if (pinInput.length == 4) {
      return 'Повторите пин-код';
    }
    return 'Придумайте пин-код';
  }
}