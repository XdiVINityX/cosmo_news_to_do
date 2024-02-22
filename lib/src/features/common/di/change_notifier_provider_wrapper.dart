import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifierProviderWrapper<T extends ChangeNotifier>
    extends StatelessWidget {
  const ChangeNotifierProviderWrapper({
    required this.provider,
    required this.builder,
    super.key,
  });

  final T provider;
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>(
        create: (context) => provider,
        child: Builder(
          builder: builder,
        ),
      );
}
