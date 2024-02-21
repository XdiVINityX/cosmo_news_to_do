import 'package:flutter/material.dart';

class PinInputWidget extends StatelessWidget {
  PinInputWidget({
    this.pinLength = 4,
    String pinInput = '',
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.errorColor = Colors.red,
    this.error = false,
    super.key,
  }) : _pinInput = pinInput.padLeft(pinLength).trim();

  final int pinLength;
  final String _pinInput;
  final bool error;

  final Color activeColor;
  final Color inactiveColor;
  final Color errorColor;

  bool _isActive(int index) => index < _pinInput.length;

  _PinInputType _getType(int index) {
    if (error) return _PinInputType.error;
    return _isActive(index) ? _PinInputType.active : _PinInputType.inactive;
  }

  Color _getColor(int index) {
    final type = _getType(index);

    switch (type) {
      case _PinInputType.inactive:
        return inactiveColor;
      case _PinInputType.active:
        return activeColor;
      case _PinInputType.error:
        return errorColor;
    }
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pinLength,
          (index) => _PinItemWidget(
            color: _getColor(index),
          ),
        ),
      );
}

enum _PinInputType {
  inactive,
  active,
  error,
}

class _PinItemWidget extends StatelessWidget {
  const _PinItemWidget({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        duration: const Duration(milliseconds: 200),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      );
}
