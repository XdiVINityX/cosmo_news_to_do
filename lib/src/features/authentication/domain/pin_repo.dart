import 'package:cosmo_news_to_do/src/features/authentication/data/source/local/i_pin_secure_storage.dart';
import 'package:cosmo_news_to_do/src/features/authentication/data/source/local/secure_storage.dart';
import 'package:cosmo_news_to_do/src/features/authentication/domain/i_pin_repo.dart';

class PinSecureStorageRepo implements IPinSecureStorageRepo {
  PinSecureStorageRepo() {
    _pinSecureStorage = const SecureStorage();
  }

  late final IPinSecureStorage _pinSecureStorage;

  @override
  Future<String?> getPinCode() async => _pinSecureStorage.getPinCode();

  @override
  Future<void> savePinCode(String pin) async =>
      _pinSecureStorage.savePinCode(pin);

  @override
  Future<void> deletePinCode() async =>  _pinSecureStorage.deletePinCode();
}
