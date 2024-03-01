import 'dart:async';

import 'package:cosmo_news_to_do/src/features/app/presentation/view/app_view.dart';
import 'package:flutter/cupertino.dart';

Future<void> run() async {
  /// it can be async in some cases
  _runApp();
}

void _runApp() {
  runZonedGuarded(() {
    /// some initializations like native splash or progress counter
    /// dependency injection and smthing like this
    runApp(AppView());
  }, (error, stack) {
    /// send errors to crashlitycs
    /// debug print errors, didnt catched above
    debugPrint('$error');
    debugPrintStack(stackTrace: stack);
    FlutterError.onError = (e) => debugPrint('$e');
  });
}
