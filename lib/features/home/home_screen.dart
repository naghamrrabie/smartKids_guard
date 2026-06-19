import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/features/home/cubit/home_cubit.dart';
import 'package:smartkids_gurad/features/home/cubit/home_state.dart';
import 'package:smartkids_gurad/features/location_traking_view/location_tracking_view.dart';

import 'widgets/home_header.dart';
import 'widgets/track_location_card.dart';
import 'widgets/section_title_row.dart';
import 'widgets/child_card.dart';
import 'widgets/emergency_title.dart';
import 'widgets/emergency_tile.dart';
import 'widgets/bottom_nav_bar.dart';

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
          if (i == 1) {
            // 💡 هنا بقى هنروح للوكيشن عن طريق الـ RoutesManager عشان الـ Cubit يتحقن!
            Navigator.pushNamedAndRemoveUntil(context, RoutesManager.locationTrackingView, (route) => false);
          } else if (i == 2) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesManager.notificationScreen, (route) => false);
          } else if (i == 3) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesManager.profileScreen, (route) => false);
          }
        }
      ),
      body:selectedIndex == 0 ? _buildHomeContent() : const LocationTrackingView(),
    );
  }
}
Widget _buildHomeContent(){
  return Column(
    children: [
      const HomeHeader(),
      Expanded(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator(color: ColorsManager.bluee));
            } else if (state is HomeError) {
              return Center(child: Text(state.error, style: const TextStyle(color: Colors.red)));
            } else if (state is HomeSuccess) {
              final childrenList = state.children;

              return ListView(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                children: [
                  const TrackLocationCard(),
                  const SizedBox(height: 16),
                  SectionTitleRow(
                    left: 'Children Status',
                    right: 'Add Child',
                    onRightTap: () => Navigator.pushNamed(context, RoutesManager.studentRegistrationRoute),
                  ),
                  const SizedBox(height: 10),

                  // لو مفيش أطفال متسجلين
                  if (childrenList.isEmpty)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("No children added yet.", style: TextStyle(color: Colors.grey, fontSize: 16)),
                    )),

                  // بنلف على الأطفال طفل طفل ونعرض الكارت بتاعه وتحته أرقام الطوارئ الخاصة بمدرسته
                  ...childrenList.map((child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChildCard(childData: child), // 💡 بصينا الداتا هنا
                      const SizedBox(height: 14),
                      const EmergencyTitle(),
                      const SizedBox(height: 12),
                      EmergencyTile(
                        iconAsset: ImageAssets.schoolAdministration,
                        title: 'School Administration',
                        phone: child.schoolAdministrationPhoneNumber, // 💡 دايناميك
                      ),
                      const SizedBox(height: 12),
                      EmergencyTile(
                        iconAsset: ImageAssets.supervisorBus,
                        title: 'Supervisor Bus',
                        phone: child.supervisorBusPhoneNumber, // 💡 دايناميك
                      ),
                      const SizedBox(height: 12),
                      EmergencyTile(
                        iconAsset: ImageAssets.schoolSecurity,
                        title: 'School Security',
                        phone: child.schoolSecurityPhoneNumber, // 💡 دايناميك
                      ),
                      const SizedBox(height: 24), // مسافة بين كل طفل والتاني
                    ],
                  )),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    ],
  );
}