import 'package:cosmo_news_to_do/src/core/application/assets/themes/app_theme.dart';
import 'package:cosmo_news_to_do/src/features/app/di/app_scope.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/source/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/bloc/picture_of_the_day_bloc.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/presentation/view/picture_of_the_day_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final appScope = AppScope();
    final pictureOfTheDayProvider =
    PictureOfTheDayApiProvider(dio: appScope.dio);
    return MaterialApp(
      title: 'Cosmo',
      theme: AppThemeData.light,
      darkTheme: AppThemeData.dark,
      // TODO(add): fix if it would be several themes
      themeMode: ThemeMode.light,
      home: BlocProvider(
        create: (context) => PictureOfTheDayBloc(PictureOfTheDayRepo(pictureOfTheDayApiProvider: PictureOfTheDayApiProvider(dio: AppScope().dio)))..add(PictureOfTheDayEventLoadMore()), // или другое событие для начальной загрузки данных
        child: const PictureOfTheDayView(),
      ),
    );
  }



/*@override
  Widget build(BuildContext context) {
    final appScope = AppScope();
    final pictureOfTheDayProvider =
        PictureOfTheDayApiProvider(dio: appScope.dio);
    return MultiProvider(
      providers: [
        Provider(create: (_) => appScope),
        Provider(
          create: (_) => pictureOfTheDayProvider,
        ),
        Provider(
          create: (_) => PictureOfTheDayRepo(
            pictureOfTheDayApiProvider: pictureOfTheDayProvider,
          ),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Cosmo',
        theme: AppThemeData.light,
        darkTheme: AppThemeData.dark,
        // TODO(add): fix if it would be several themes
        themeMode: ThemeMode.light,
        home: ChangeNotifierProvider(
          // TODO(add): read interface
          create: (_) =>
              PictureOfTheDayViewModel(context.read<PictureOfTheDayRepo>())
                ..loadPictures(),
          child: const PictureOfTheDayView(),
        ),
      ),
    );
  }*/
}
