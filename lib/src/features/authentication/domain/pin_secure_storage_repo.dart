import '../data/source/local/secure_storage.dart';
import 'i_pin_secure_storage_repo.dart';

class PinSecureStorageRepo implements IPinSecureStorageRepo{
  late SecureStorage secureStorage;

  @override
  Future<String?> getPinCode() async {
    return await secureStorage.storage.read(key:'pin');
  }

  @override
  Future<void> savePinCode(String pin) async {
    await secureStorage.storage.write(key: 'pin', value: pin);
  }

  PinSecureStorageRepo() {
    secureStorage = const SecureStorage();
  }
}