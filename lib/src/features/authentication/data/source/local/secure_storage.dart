import 'package:cosmo_news_to_do/src/features/authentication/domain/interface/pin_code_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const pinKey = 'pinKey';

class SecureStorage implements PinCodeSecureStorage {
  const SecureStorage();
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> deletePinCode() async {
    await _storage.delete(key: pinKey);
  }

  @override
  Future<String?> getPinCode() async{
   await _storage.read(key: pinKey);
  }

  @override
  Future<void> savePinCode(String pin) async{
    await _storage.write(key: pinKey, value: pin);
  }
}
