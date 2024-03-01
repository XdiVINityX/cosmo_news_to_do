import 'package:cosmo_news_to_do/src/core/application/assets/themes/app_theme.dart';
import 'package:cosmo_news_to_do/src/features/app/presentation/data/source/network/dio_app_scope.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/source/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/picture_of_the_day_view_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/view/picture_of_the_day_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AppView extends StatelessWidget {
  AppView({super.key});



// TODO(add): multirovider with repo,dio above materialApp
  @override
  Widget build(BuildContext context) {
    final pictureOfTheDayProvider = PictureOfTheDayApiProvider(dio: DioAppScope());
    return MultiProvider(
        providers: [
          Provider(create: (_) => pictureOfTheDayProvider),
          Provider(create: (_) => PictureOfTheDayRepo(pictureOfTheDayApiProvider:pictureOfTheDayProvider)),
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
}
