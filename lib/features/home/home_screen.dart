import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/routes_manager.dart';
import 'widgets/home_header.dart';
import 'widgets/track_location_card.dart';
import 'widgets/section_title_row.dart';
import 'widgets/child_card.dart';
import 'widgets/emergency_title.dart';
import 'widgets/emergency_tile.dart';
import 'widgets/bottom_nav_bar.dart';
import '../../core/resources/assets_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,

      bottomNavigationBar: BottomNavBar(
        currentIndex: selectedIndex,
        onTap: (i) {
          if (i == 2) {
            Navigator.pushNamed(
              context,
              RoutesManager.notificationScreen,
            );
          } else if (i == 3) {
            Navigator.pushNamed(
              context,
              RoutesManager.profileScreen,
            );
          } else {
            setState(() => selectedIndex = i);
          }
        },
      ),

      body: Column(
        children: [
          const HomeHeader(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
              children: [
                const TrackLocationCard(),
                const SizedBox(height: 16),

                /// هنا خلينا Add Child زرار يروح لصفحة Student Registration
                SectionTitleRow(
                  left: 'Children Status',
                  right: 'Add Child',
                  onRightTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.studentRegistrationRoute,
                    );
                  },
                ),
                const SizedBox(height: 10),

                const ChildCard(),
                const SizedBox(height: 14),

                const EmergencyTitle(),
                const SizedBox(height: 12),

                const EmergencyTile(
                  iconAsset: ImageAssets.schoolAdministration,
                  title: 'School Administration',
                  phone: '010235484124',
                ),
                const SizedBox(height: 12),

                const EmergencyTile(
                  iconAsset: ImageAssets.supervisorBus,
                  title: 'Supervisor Bus',
                  phone: '010235484124',
                ),
                const SizedBox(height: 12),

                const EmergencyTile(
                  iconAsset: ImageAssets.schoolSecurity,
                  title: 'School Security',
                  phone: '01006040938',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}