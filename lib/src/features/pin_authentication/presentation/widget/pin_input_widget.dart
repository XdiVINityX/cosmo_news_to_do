import 'package:flutter/material.dart';

class PinInputWidget extends StatefulWidget {
  const PinInputWidget({
    this.pinLength = 4,
    this.pinInput = '',
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.errorColor = Colors.red,
    this.error = false,
    this.onComplete,
    super.key,
  });

  final int pinLength;
  final String pinInput;
  final bool error;

  final Color activeColor;
  final Color inactiveColor;
  final Color errorColor;

  final VoidCallback? onComplete;

  @override
  State<PinInputWidget> createState() => _PinInputWidgetState();
}

class _PinInputWidgetState extends State<PinInputWidget> {
  late final ValueNotifier<String> _pinInput;

  @override
  void initState() {
    super.initState();
    _pinInput = ValueNotifier(widget.pinInput.padLeft(widget.pinLength).trim())
      ..addListener(_pinChangeListener);
  }

  @override
  void didUpdateWidget(PinInputWidget oldWidget) {
    _pinInput.value = widget.pinInput.padLeft(widget.pinLength).trim();
    super.didUpdateWidget(oldWidget);
  }

  void _pinChangeListener() {
    if (_pinInput.value.length == widget.pinLength) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _pinInput.value = '';
        widget.onComplete?.call();
      });
    }
  }

  bool _isActive(int index) => index < _pinInput.value.length;

  _PinInputType _getType(int index) {
    if (widget.error) return _PinInputType.error;
    return _isActive(index) ? _PinInputType.active : _PinInputType.inactive;
  }

  Color _getColor(int index) {
    final type = _getType(index);

    switch (type) {
      case _PinInputType.inactive:
        return widget.inactiveColor;
      case _PinInputType.active:
        return widget.activeColor;
      case _PinInputType.error:
        return widget.errorColor;
    }
  }

  @override
  void dispose() {
    _pinInput
      ..removeListener(_pinChangeListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.pinLength,
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
