abstract interface class PinSecureStorageRepository {
  Future<void> savePinCode(String pin);

  Future<String?> getPinCode();

  Future<void> deletePinCode();
}
