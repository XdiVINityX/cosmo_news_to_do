import '../data/source/local/secure_storage.dart';
import 'i_pin_secure_storage_repo.dart';

class PinSecureStorageRepo implements IPinSecureStorageRepo {
  PinSecureStorageRepo() {
    _secureStorage = const SecureStorage();
  }
  late final SecureStorage _secureStorage;

  @override
  Future<String?> getPinCode() async => _secureStorage.storage.read(key: 'pin');

  @override
  Future<void> savePinCode(String pin) async =>
      _secureStorage.storage.write(key: 'pin', value: pin);

  Future<void> deletePinCode() async => _secureStorage.storage.deleteAll();
}
