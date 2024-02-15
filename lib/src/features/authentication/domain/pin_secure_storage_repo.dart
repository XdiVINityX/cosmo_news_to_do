import '../data/source/local/secure_storage.dart';
import 'i_pin_secure_storage_repo.dart';

class PinSecureStorageRepo implements IPinSecureStorageRepo{
  late SecureStorage _secureStorage;

  @override
  Future<String?> getPinCode() async {
    return await _secureStorage.storage.read(key:'pin');
  }

  @override
  Future<void> savePinCode(String pin) async {
    await _secureStorage.storage.write(key: 'pin', value: pin);
  }

  Future<void> deletePinCode() async {
    await _secureStorage.storage.deleteAll();
  }

  PinSecureStorageRepo() {
    _secureStorage = const SecureStorage();
  }
}