sealed class PinState {}

class Loading implements PinState {}

class Success implements PinState {}

class Authenticated implements PinState {}

class AuthError implements PinState {}

class Error implements PinState {
  const Error({
    required this.message,
  });
  final String message;
}
