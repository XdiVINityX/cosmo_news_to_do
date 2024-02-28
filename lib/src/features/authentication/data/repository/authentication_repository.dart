import 'package:cosmo_news_to_do/src/features/authentication/data/source/local/secure_storage.dart';
import 'package:cosmo_news_to_do/src/features/authentication/domain/interface/pin_code_secure_storage.dart';
import 'package:cosmo_news_to_do/src/features/authentication/domain/interface/pin_code_secure_storage_repository.dart';

class AuthenticationRepository implements PinSecureStorageRepository {
  AuthenticationRepository() {
    _pinSecureStorage = const SecureStorage();
  }

  late final PinCodeSecureStorage _pinSecureStorage;

  @override
  Future<String?> getPinCode() async => _pinSecureStorage.getPinCode();

  @override
  Future<void> savePinCode(String pin) async =>
      _pinSecureStorage.savePinCode(pin);

  @override
  Future<void> deletePinCode() async =>  _pinSecureStorage.deletePinCode();
}
