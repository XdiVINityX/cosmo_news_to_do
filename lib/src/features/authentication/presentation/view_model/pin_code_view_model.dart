import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../../domain/pin_secure_storage_repo.dart';
import '../state/authentication_state.dart';

class PinCodeViewModel extends ChangeNotifier {

  final StreamController<PinState> _pinCodeStateStreamController = StreamController<PinState>.broadcast();
  Stream<PinState> get pinCodeStateStream => _pinCodeStateStreamController.stream;

  late String pinInput;
  late String pinInputRepeat;
  late bool _isFirstTry;
  late PinSecureStorageRepo _pinSecureStorageRepo;
  late String? _pin;
  late bool havePin;

  PinCodeViewModel() {
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
    if (pinInput.length < 4) {
      pinInput += number;
      log('pinInput = $pinInput');
      notifyListeners();
    } else if (pinInputRepeat.length < 4){
      pinInputRepeat += number;
      log('pinInputRepeat = $pinInputRepeat');
      notifyListeners();
    }
    if (pinInput.length == 4 && pinInputRepeat.length == 4){
      _checkCodes();
    }
  }

  void _clear(){
    log('Ввод очищен = $_isFirstTry');
    pinInput = '';
    pinInputRepeat = '';
  }

  void _checkCodes(){
    if((pinInput == pinInputRepeat)){
      updateState(Authenticated());
    }
    else {
      _isFirstTry = false;
      _clear();
      notifyListeners();
    }
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
    if (havePin) {
      return 'Введите пин-код';
    }
    if (pinInput.length == 4) {
      return 'Повторите пин-код';
    }
    if (!_isFirstTry) {
      _isFirstTry = true;
      return 'Пин-код не совпадает, повторите';
    }
    return 'Придумайте пин-код';
  }
}