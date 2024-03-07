import 'package:cosmo_news_to_do/src/core/application/assets/themes/app_theme.dart';
import 'package:cosmo_news_to_do/src/features/app/di/app_scope.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/repository/picture_of_the_day_repo.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/data/source/network/picture_of_the_day_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/domain/view_model/picture_of_the_day_view_model/picture_of_the_day_view_model.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day/presentation/view/picture_of_the_day_view.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/data/repository/picture_of_the_day_copy_repository.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/data/source/network/picture_of_the_day_copy_api_provider.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/domain/bloc/picture_of_the_day_bloc.dart';
import 'package:cosmo_news_to_do/src/features/picture_of_the_day_bloc/presentation/view/picture_of_the_day_copy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AppView extends StatefulWidget {
   AppView({super.key});
  final pictureOfTheDayProvider =  PictureOfTheDayApiProvider(dio: AppScope().dio);


  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final pictureOfTheDayProvider =  PictureOfTheDayApiProvider(dio: AppScope().dio);
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  static final List<Widget> _widgetOptions = <Widget>[
    // TODO(inject): add inject in bloc
    BlocProvider(
      create: (context) => PictureOfTheDayBloc(
        PictureOfTheDayCopyRepository(
          pictureOfTheDayApiProvider:
              PictureOfTheDayCopyApiProvider(dio: AppScope().dio),
        ),
      )..add(PictureOfTheDayEventLoadInitial()),
      child: const PictureOfTheDayCopyView(),
    ),
    ChangeNotifierProvider(
      create: (context) =>
          PictureOfTheDayViewModel(context.read<PictureOfTheDayRepo>())
            ..loadPictures(),
      child: const PictureOfTheDayView(),
    ),
    const Text(
      'Index 2: Настройки',
    ),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appScope = AppScope();
    final pictureOfTheDayProvider = PictureOfTheDayApiProvider(dio: appScope.dio);
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
      child: MaterialApp(
        title: 'Cosmo',
        theme: AppThemeData.light,
        darkTheme: AppThemeData.dark,
        // TODO(add): fix if it would be several themes
        themeMode: ThemeMode.light,
        home: Scaffold(
          body: SafeArea(child: Center(child: _widgetOptions[_selectedIndex])),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'BloC'),
              BottomNavigationBarItem(icon: Icon(Icons.pattern), label: 'MVVM'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'настройки',),
            ],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
