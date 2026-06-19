import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/di/di_container.dart';
import 'package:smartkids_gurad/features/Notification/cubit/notification_cubit_states.dart';
import 'package:smartkids_gurad/features/home/cubit/home_cubit.dart';
import 'package:smartkids_gurad/features/location_traking_view/add_safe_zone_screen.dart';
import 'package:smartkids_gurad/features/location_traking_view/cubit/safe_zone_cubit_states.dart';
import 'package:smartkids_gurad/features/location_traking_view/data/models/safe_zone_model.dart';
import 'package:smartkids_gurad/features/location_traking_view/location_tracking_view.dart';
import 'package:smartkids_gurad/features/login/cubit/login_cubit.dart';
import 'package:smartkids_gurad/features/login/login.dart';
import 'package:smartkids_gurad/features/onboarding/onboarding.dart';
import 'package:smartkids_gurad/features/profile_screen/about_smartkids_guard.dart';
import 'package:smartkids_gurad/features/profile_screen/cubit/profile_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/my_child_model.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/profile_model.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/child_cubit/edit_child_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/help_support_screen.dart';
import 'package:smartkids_gurad/features/splash/splash.dart';
import 'package:smartkids_gurad/features/student%20registration/cubit/create_child_cubit.dart';
import '../features/Notification/NotificationScreen.dart';
import '../features/confirm_mobile_num/confirm_mobile_num.dart';
import '../features/confirm_mobile_num/mobile_num_confirmed.dart';
import '../features/create_account/create_account.dart';
import '../features/forget_password/change_done.dart';
import '../features/forget_password/code_reset.dart';
import '../features/forget_password/ent_new_password.dart';
import '../features/forget_password/reset_password.dart';
import '../features/home/home_screen.dart';
import '../features/profile_screen/edit_profile/edit_child_profile.dart';
import '../features/profile_screen/edit_profile/edit_profile.dart';
import '../features/profile_screen/profile_screen.dart';
import '../features/student registration/student_device.dart';
import '../features/student registration/student_registration.dart';

class RoutesManager {

  static const String SplashRoute = "/Splash";
  static const String onBoardingRoute= "/onBoarding";
  static const String login= "/login";
  static const String createAccountRoute = "/CreateAccount";
  static const String studentRegistrationRoute = "/StudentRegistration";
  static const String confirmMobileNum = "/ConfirmMobileNum";
  static const String mobileNumConfirmed = "/MobileNumConfirmed";
  static const String studentDevice = "/StudentDevice";
  static const String resetPassword = "/ResetPassword";
  static const String codeReset = "/CodeReset";
  static const String enterNewPassword = "/EnterNewPassword";
  static const String changeDone = "/ChangeDone";
  static const String  homeScreen = "/HomeScreen";
  static const String   profileScreen = "/ ProfileScreen";
  static const String helpSupportScreen = "/HelpSupportScreen";
  static const String aboutSmartKidsGuard= "/AboutSmartKidsGuard";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String editChildProfile = "/EditChildProfile";
  static const String notificationScreen = "/NotificationScreen";
  static const String locationTrackingView = "/location-tracking-view";
  static const String addSafeZoneScreen="add-safe-zone";



  static Map<String, WidgetBuilder> routes = {
    SplashRoute: (_) => Splash(),
    onBoardingRoute: (_) => Onboarding(),
   login : (_) => BlocProvider(
     create: (context) => getIt<LoginCubit>(), // هنا استخدمنا getIt
     child: const Login(),
   ),
    createAccountRoute: (_) => const CreateAccount(),
    studentRegistrationRoute: (_) => BlocProvider( create: (context) =>getIt<CreateChildCubit>(),
    child: const StudentRegistration()),
    confirmMobileNum: (_) => const ConfirmMobileNum(),
    mobileNumConfirmed: (_) => const MobileNumConfirmed(),
    studentDevice: (_) => const StudentDevice(),
    resetPassword: (_) => const ResetPassword(),
    codeReset: (_) => const CodeReset(),
    enterNewPassword: (_) => const EnterNewPassword(),
    changeDone: (_) => const ChangeDone(),
    homeScreen: (_) => BlocProvider(
      create: (context) => getIt<HomeCubit>()..fetchChildren(),
      child: const HomeScreen(),
    ),
    profileScreen: (_) => BlocProvider(
      // التريكة هنا إننا بننادي على getProfile() بمجرد ما الـ Cubit يتكريت
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: const ProfileScreen(),
    ),
    helpSupportScreen: (_) => const HelpSupportScreen(),
    aboutSmartKidsGuard: (_) => const AboutSmartKidsGuard(),
    editProfileScreen: (context) {
      // بنستقبل الداتا اللي جاية من الشاشة اللي قبلها
      final profileData = ModalRoute.of(context)!.settings.arguments as ProfileResponseModel;
      return BlocProvider(
        create: (context) => getIt<EditProfileCubit>(),
        child: EditProfileScreen(profileData: profileData),
      );
    },
    // اتأكد إنك عامل Import لـ MyChildModel
    editChildProfile: (context) {
      final childData = ModalRoute.of(context)!.settings.arguments as MyChildModel;
      return BlocProvider(
        create: (context) => getIt<EditChildCubit>(),
        child: EditChildProfile(childData: childData),
      );
    },
    notificationScreen: (_) => BlocProvider(
      create: (context) => getIt<NotificationCubit>(), // الشاشة نفسها بتنادي الدالة في الـ initState
      child: const NotificationScreen(),
    ),
    locationTrackingView: (_) => BlocProvider(
      create: (context) => getIt<SafeZoneCubit>()..fetchSafeZones(),
      child: const LocationTrackingView(),
    ),
    addSafeZoneScreen: (context) {
      // بنستقبل اللستة القديمة من الشاشة اللي فاتت
      final existingZones = ModalRoute.of(context)!.settings.arguments as List<SafeZoneModel>;
      return BlocProvider.value(
        value: getIt<SafeZoneCubit>(), // 💡 بنستخدم نفس الـ Cubit عشان لما يضيف يعمل تحديث للشاشة الرئيسية
        child: AddSafeZoneScreen(existingZones: existingZones),
      );
    },
  };
}