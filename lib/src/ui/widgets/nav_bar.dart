import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rengi_filim/src/utils/constants/lang_keys.dart';

// ignore: must_be_immutable
class NavBar extends StatelessWidget {
  int currentTab;
  void Function(int index) onChanged;
  NavBar({super.key, required this.currentTab, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: List.generate(
        navTitles.length,
        (i) {
          return BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Icon(
                navIcons[i],
              ),
            ),
            label: navTitles[i],
          );
        },
      ),
      currentIndex: currentTab,
      onTap: onChanged,
      selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
      selectedFontSize: 8,
      unselectedFontSize: 8,
      iconSize: 25,
    );
  }

  List navTitles = [
    LangKey.movies.tr(),
    LangKey.favorites.tr(),
    LangKey.about.tr(),
  ];

  List<IconData> navIcons = [
    Iconsax.video_play,
    Iconsax.heart,
    Iconsax.information,
  ];
}
