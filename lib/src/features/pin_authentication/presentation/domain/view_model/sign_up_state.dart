import 'package:cosmo_news_to_do/src/features/pin_authentication/presentation/domain/entity/pin_request_entity.dart';

sealed class SignUpState {
  PinRequestEntity get pinInputData;
  bool get repeatMode;

  SignUpState copyWith({
    PinRequestEntity? pinInputData,
    bool? repeatMode,
  });
}

final class SignUpState$Idle implements SignUpState {
  const SignUpState$Idle({
    this.pinInputData = PinRequestEntity.initial,
    this.repeatMode = false,
  });
  @override
  final PinRequestEntity pinInputData;
  @override
  final bool repeatMode;

  @override
  SignUpState$Idle copyWith({
    PinRequestEntity? pinInputData,
    bool? repeatMode,
  }) =>
      SignUpState$Idle(
        pinInputData: pinInputData ?? this.pinInputData,
        repeatMode: repeatMode ?? this.repeatMode,
      );
}

final class SignUpState$Success implements SignUpState {
  const SignUpState$Success({
    required this.pinInputData,
    required this.repeatMode,
  });
  @override
  final PinRequestEntity pinInputData;
  @override
  final bool repeatMode;

  @override
  SignUpState$Success copyWith({
    PinRequestEntity? pinInputData,
    bool? repeatMode,
  }) =>
      SignUpState$Success(
        pinInputData: pinInputData ?? this.pinInputData,
        repeatMode: repeatMode ?? this.repeatMode,
      );
}

final class SignUpState$Error implements SignUpState {
  const SignUpState$Error({
    required this.pinInputData,
    required this.repeatMode,
    required this.message,
  });
  @override
  final PinRequestEntity pinInputData;
  @override
  final bool repeatMode;
  final String message;

  @override
  SignUpState$Error copyWith({
    PinRequestEntity? pinInputData,
    bool? repeatMode,
    String? message,
  }) =>
      SignUpState$Error(
        pinInputData: pinInputData ?? this.pinInputData,
        repeatMode: repeatMode ?? this.repeatMode,
        message: message ?? this.message,
      );
}
