import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rengi_filim/src/ui/screens/about_screen.dart';
import 'package:rengi_filim/src/ui/widgets/app_bar/app_bar.dart';

import '../../bloc/favorites/favorites_bloc.dart';
import '../widgets/nav_bar.dart';
import 'movie/favorites_screen.dart';
import 'movie/movies_screen.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int currentPage = 0;

  @override
  void initState() {
    context.read<FavoritesBloc>().add(FetchingFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      bottomNavigationBar: NavBar(
        currentTab: currentPage,
        onChanged: (index) => setState(() {
          currentPage = index;
        }),
      ),
      body: screens[currentPage],
    );
  }

  List<Widget> screens = [
    const MoviesScreen(),
    const FavoritesScreen(),
    const AboutUsScreen()
  ];
}
