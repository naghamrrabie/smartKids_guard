import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:smartkids_gurad/core/network/dio_factory.dart';
import 'package:smartkids_gurad/features/Notification/cubit/notification_cubit_states.dart';
import 'package:smartkids_gurad/features/Notification/domin/notification_repo.dart';
import 'package:smartkids_gurad/features/home/cubit/home_cubit.dart';
import 'package:smartkids_gurad/features/home/domin/home_repo.dart';
import 'package:smartkids_gurad/features/location_traking_view/cubit/safe_zone_cubit_states.dart';
import 'package:smartkids_gurad/features/location_traking_view/domin/safe_zone_repo.dart';
import 'package:smartkids_gurad/features/login/cubit/login_cubit.dart';
import 'package:smartkids_gurad/features/login/domin/login_repo.dart';
import 'package:smartkids_gurad/features/profile_screen/cubit/profile_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/domin/profile_repo.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/child_cubit/edit_child_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/child_domin/edit_child_repo.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:smartkids_gurad/features/student%20registration/cubit/create_child_cubit.dart';
import 'package:smartkids_gurad/features/student%20registration/domin/child_repo.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async{
  // بنكريت الـ Dio عن طريق الـ Factory ونديه للـ DI يحفظه كـ Singleton
  getIt.registerLazySingleton<Dio>(() => DioFactory().getDio());



  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo( dio: getIt<Dio>()));

  // الـ Cubit بياخد الـ Repo
  getIt.registerFactory<LoginCubit>(() => LoginCubit(loginRepo: getIt<LoginRepo>()));

  // Profile Parent
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(dio: getIt<Dio>()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(profileRepo: getIt<ProfileRepo>()));
  getIt.registerFactory<EditProfileCubit>(() => EditProfileCubit(profileRepo: getIt<ProfileRepo>()));

  // Create Child
  getIt.registerLazySingleton<ChildRepo>(() => ChildRepo(dio: getIt<Dio>()));
  getIt.registerFactory<CreateChildCubit>(() => CreateChildCubit(childRepo: getIt<ChildRepo>()));

  //update child (image,data)
  getIt.registerLazySingleton<EditChildRepo>(() => EditChildRepo(dio: getIt<Dio>()));
  getIt.registerFactory<EditChildCubit>(() => EditChildCubit(editChildRepo: getIt<EditChildRepo>()));

  //home child parent
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(dio: getIt<Dio>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(homeRepo: getIt<HomeRepo>()));

  // Notification
  getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepo(dio: getIt<Dio>()));
  getIt.registerFactory<NotificationCubit>(() => NotificationCubit(notificationRepo: getIt<NotificationRepo>()));

  // Safe Zones
  getIt.registerLazySingleton<SafeZoneRepo>(() => SafeZoneRepo(dio: getIt<Dio>()));
  getIt.registerFactory<SafeZoneCubit>(() => SafeZoneCubit(safeZoneRepo: getIt<SafeZoneRepo>()));

}