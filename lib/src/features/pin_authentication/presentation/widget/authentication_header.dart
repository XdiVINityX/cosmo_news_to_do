import 'package:flutter/material.dart';

class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      );
}
