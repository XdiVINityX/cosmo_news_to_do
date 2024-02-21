import 'package:flutter/cupertino.dart';

@immutable
class PinRequestEntity {
  const PinRequestEntity({
    required this.pin,
    required this.repeatPin,
  });

  static const initial = PinRequestEntity(pin: '', repeatPin: '');
  final String pin;
  final String repeatPin;

  bool get isEquals => pin == repeatPin;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PinRequestEntity &&
          runtimeType == other.runtimeType &&
          pin == other.pin &&
          repeatPin == other.repeatPin;

  @override
  int get hashCode => pin.hashCode ^ repeatPin.hashCode;

  PinRequestEntity copyWith({
    String? pin,
    String? repeatPin,
  }) =>
      PinRequestEntity(
        pin: pin ?? this.pin,
        repeatPin: repeatPin ?? this.repeatPin,
      );
}
