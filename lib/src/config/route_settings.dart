import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rengi_filim/src/data/models/movie_list.dart';
import 'package:rengi_filim/src/ui/screens/movie/detail_screen.dart';
import 'package:rengi_filim/src/ui/screens/settings_screen.dart';

import '../ui/screens/tabs.dart';
import '../utils/constants/route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    if (Platform.isAndroid) {
      return MaterialPageRoute(
        builder: (BuildContext context) => getScreen(settings.name, args),
      );
    } else {
      return CupertinoPageRoute(
        builder: (BuildContext context) => getScreen(settings.name, args),
      );
    }
  }

  static getScreen(name, args) {
    switch (name) {
      case KRoutes.initial:
        return const Tabs();
      case KRoutes.detail:
        return MovieDetailScreen(
          movie: args as MovieData,
        );
      case KRoutes.setting:
        return SettingsScreen();

      default:
        return Container();
    }
  }
}
