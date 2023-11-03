import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rengi_filim/src/bloc/favorites/favorites_bloc.dart';
import 'package:rengi_filim/src/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:rengi_filim/src/config/theme/light_theme.dart';
import 'package:rengi_filim/src/utils/constants/route_names.dart';

import 'bloc/movie_list/movie_list_bloc.dart';
import 'config/route_settings.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieListBloc(),
        ),
        BlocProvider(
          create: (context) => MovieDetailBloc(),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: KRoutes.initial,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
