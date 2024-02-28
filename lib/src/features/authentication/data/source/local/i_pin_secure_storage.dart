abstract interface class IPinSecureStorage {
  Future<void> savePinCode(String pin);

  Future<String?> getPinCode();

  Future<void> deletePinCode();
}
