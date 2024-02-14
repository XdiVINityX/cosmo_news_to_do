
abstract interface class IPinSecureStorageRepo {
  Future<void> savePinCode(String pin) async { }

  Future<String?> getPinCode() async {
    return null;
  }
}