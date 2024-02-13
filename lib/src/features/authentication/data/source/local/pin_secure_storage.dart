import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinSecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> savePinCode(String pin) async {
    await _storage.write(key: 'pinCode', value: pin);
  }

  Future<String?> getPinCode() async {
    return await _storage.read(key: 'pinCode');
  }

  const PinSecureStorage();
}