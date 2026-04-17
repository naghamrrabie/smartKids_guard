import 'package:flutter/material.dart';
import 'package:smartkids_gurad/features/login/login.dart';
import 'package:smartkids_gurad/features/onboarding/onboarding.dart';
import 'package:smartkids_gurad/features/profile_screen/AboutSmartKidsGuard.dart';
import 'package:smartkids_gurad/features/profile_screen/HelpSupportScreen.dart';
import 'package:smartkids_gurad/features/splash/splash.dart';
import '../features/Notification/NotificationScreen.dart';
import '../features/confirm_mobile_num/confirm_mobile_num.dart';
import '../features/confirm_mobile_num/mobile_num_confirmed.dart';
import '../features/cteate_account/create_account.dart';
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


  static Map<String, WidgetBuilder> routes = {
    SplashRoute: (_) => Splash(),
    onBoardingRoute: (_) => Onboarding(),
   login : (_) => Login(),
    createAccountRoute: (_) => const CreateAccount(),
    studentRegistrationRoute: (_) => const StudentRegistration(),
    confirmMobileNum: (_) => const ConfirmMobileNum(),
    mobileNumConfirmed: (_) => const MobileNumConfirmed(),
    studentDevice: (_) => const StudentDevice(),
    resetPassword: (_) => const ResetPassword(),
    codeReset: (_) => const CodeReset(),
    enterNewPassword: (_) => const EnterNewPassword(),
    changeDone: (_) => const ChangeDone(),
    homeScreen: (_) => const HomeScreen(),
    profileScreen: (_) => const  ProfileScreen(),
    helpSupportScreen: (_) => const HelpSupportScreen(),
    aboutSmartKidsGuard: (_) => const AboutSmartKidsGuard(),
    editProfileScreen: (_) => const EditProfileScreen(),
    editChildProfile: (_) => const EditChildProfile(),
    notificationScreen: (_) => const NotificationScreen(),

  };
}