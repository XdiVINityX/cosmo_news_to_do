class AppException implements Exception {
  AppException({
    this.message = 'Что-то пошло не так',
    required this.internalMessage,
  });
  final String message;
  final String internalMessage;
}
