import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinSecureStorageService {
  final storage = const FlutterSecureStorage();

  Future<void> savePinCode(String pin) async {
    await storage.write(key: 'pinCode', value: pin);
  }

  Future<String?> getPinCode() async {
    return await storage.read(key: 'pinCode');
  }
}