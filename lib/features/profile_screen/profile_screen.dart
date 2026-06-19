import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';

import 'package:smartkids_gurad/features/profile_screen/cubit/profile_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/cubit/profile_state.dart';

import 'package:smartkids_gurad/features/profile_screen/widgets/notification_setting_card.dart';
import 'package:smartkids_gurad/features/profile_screen/widgets/profile_header.dart';
import '../home/widgets/bottom_nav_bar.dart';
import 'widgets/profile_info_card.dart';
import 'widgets/child_profile_tile.dart';
import 'widgets/app_setting_tile.dart';
import 'widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesManager.homeScreen, (route) => false);
          }
        },
      ),
      // 💡 استخدمنا BlocConsumer عشان نستمع للـ SnackBar
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) => current is ProfileNotificationActionError,
        buildWhen: (previous, current) => current is! ProfileNotificationActionError,
        listener: (context, state) {
          if (state is ProfileNotificationActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator(color: ColorsManager.bluee));
          } else if (state is ProfileError) {
            return Center(child: Text(state.error, style: const TextStyle(color: Colors.red, fontSize: 16)));
          } else if (state is ProfileSuccess) {
            final profile = state.profile;
            final childrenList = state.children;

            return Column(
              children: [
                const ProfileHeader(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                    children: [
                      ProfileInfoCard(profileData: profile),
                      const SizedBox(height: 22),

                      _SectionHeader(
                        title: 'Children Profiles',
                        actionText: 'Add Child',
                        onActionTap: () => Navigator.pushNamed(context, RoutesManager.studentRegistrationRoute),
                      ),
                      const SizedBox(height: 12),

                      if (childrenList.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 22),
                          child: Text("No children added yet.", style: TextStyle(color: Colors.grey)),
                        ),
                      ...childrenList.map((child) => ChildProfileTile(child: child)),

                      const SizedBox(height: 10),
                      const _SectionOnlyTitle(title: 'Notifications'),
                      const SizedBox(height: 12),

                      // 💡 باصينا الداتا بتاعت الأب للكارت عشان يقرا حالة السويتش
                      NotificationSettingsCard(profile: profile),

                      const SizedBox(height: 22),
                      const _SectionOnlyTitle(title: 'App Setting'),
                      const SizedBox(height: 12),
                      const AppSettingTile(),
                      const SizedBox(height: 32),
                      const LogoutButton(),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

// =======================================================
// Widgets مساعدة لـ ProfileScreen (نفس اللي كانت عندك)
// =======================================================
class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;

  const _SectionHeader({
    required this.title,
    required this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onActionTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              actionText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: ColorsManager.bluee,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionOnlyTitle extends StatelessWidget {
  final String title;

  const _SectionOnlyTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}