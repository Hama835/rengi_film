import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rengi_filim/src/config/color/light_colors.dart';
import 'package:rengi_filim/src/utils/constants/lang_keys.dart';

AppBar mainAppBar(BuildContext context) => AppBar(
      title: Row(
        children: [
          Image.asset(
            "assets/images/logo/app_logo.png",
            height: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            LangKey.appName.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      actions: [
        IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          onPressed: () => Navigator.pushNamed(context, "/setting"),
          icon: Icon(
            Iconsax.setting_2,
            size: 26,
            color: LightColors.mutedBlack,
          ),
        ),
      ],
    );
AppBar generalAppBar(BuildContext context, String title) => AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      leadingWidth: 40,
      leading: IconButton(
        iconSize: 26,
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: LightColors.mutedBlack,
        ),
      ),
    );
// flutter build apk --split-per-abi --obfuscate --split-debug-info=/rengi_filim/debug_info 
