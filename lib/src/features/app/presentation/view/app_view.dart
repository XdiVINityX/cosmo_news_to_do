import 'package:cosmo_news_to_do/src/core/application/assets/themes/app_theme.dart';
import 'package:cosmo_news_to_do/src/features/authentication/presentation/view/pin_code_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmo',
      theme: AppThemeData.light,
      darkTheme: AppThemeData.dark,
      // TODO(add): fix if it would be several themes
      themeMode: ThemeMode.light,
      home: ChangeNotifierProvider(create: (_) => PinCodeViewModel(),child: const PinCodeView()),
    );
  }
}
