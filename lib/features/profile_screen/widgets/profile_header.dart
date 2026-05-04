import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import '../../../core/widgets/app_top_headerr.dart';
import 'menu.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTopHeader(
      title: 'Profile&Setting',
      height: 130,
      trailing: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (_) => const MenuScreen(),
          );
        },
        icon: Image.asset(
          ImageAssets.rivetIconsSettings,
          width: 26,
          height: 26,
          color: Colors.black,
        ),
      ),
    );
  }
}