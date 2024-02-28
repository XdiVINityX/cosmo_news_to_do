abstract interface class PinCodeSecureStorage {
  Future<void> savePinCode(String pin);

  Future<String?> getPinCode();

  Future<void> deletePinCode();
}
