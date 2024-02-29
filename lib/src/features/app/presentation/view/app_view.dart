import 'package:cosmo_news_to_do/src/core/application/assets/themes/app_theme.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/picture_of_the_day_view_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/view/picture_of_the_day_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

// TODO(add): multirovider with repo,dio above materialApp
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => PictureOfTheDayRepo()),
        ],
        builder: (context, child) => MaterialApp(
          title: 'Cosmo',
          theme: AppThemeData.light,
          darkTheme: AppThemeData.dark,
          // TODO(add): fix if it would be several themes
          themeMode: ThemeMode.light,
          home: ChangeNotifierProvider(
            // TODO(add): read interface
            create: (_) => PictureOfTheDayViewModel(context.read<PictureOfTheDayRepo>()),
            child: const PictureOfTheDayView(),
          ),
        ),
      );
}
