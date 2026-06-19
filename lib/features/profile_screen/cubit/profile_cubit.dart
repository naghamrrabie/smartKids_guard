import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/features/profile_screen/cubit/profile_state.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/my_child_model.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/profile_model.dart';
import 'package:smartkids_gurad/features/profile_screen/domin/profile_repo.dart';
// استدعي الـ Repo والـ States

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      // 💡 السطر ده بيضرب الاتنين APIs في نفس اللحظة (توفير للوقت)
      final results = await Future.wait([
        profileRepo.getProfile(),
        profileRepo.getMyChildren(),
      ]);

      final profileData = results[0] as ProfileResponseModel;
      final childrenList = results[1] as List<MyChildModel>;

      emit(ProfileSuccess(profileData, childrenList)); // بنبعتهم هما الاتنين للشاشة
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
  // ==========================================
  // دالة التحكم في زرار الإشعارات (ON / OFF)
  // ==========================================
  Future<void> togglePushNotifications(bool isEnabled) async {
    // لازم نتأكد إن الداتا كانت متحملة أصلاً
    if (state is! ProfileSuccess) return;

    final currentState = state as ProfileSuccess;
    String token = "disabled";

    try {
      if (isEnabled) {
        FirebaseMessaging messaging = FirebaseMessaging.instance;
        // 1. نسأل على الصلاحية
        NotificationSettings settings = await messaging.requestPermission();

        if (settings.authorizationStatus == AuthorizationStatus.authorized ||
            settings.authorizationStatus == AuthorizationStatus.provisional) {
          // 2. لو وافق، نجيب التوكن
          token = await messaging.getToken() ?? "no-token";
        } else {
          // 3. لو رفض من إعدادات الموبايل
          emit(ProfileNotificationActionError("تم إلغاء الإشعارات من إعدادات الهاتف، يرجى تفعيلها يدوياً."));
          // بنرجع نعرض الشاشة تاني عشان الزرار يرجع OFF لوحده
          emit(ProfileSuccess(currentState.profile, currentState.children));
          return;
        }
      }

      // 4. نكلم الـ API ونحدث السيرفر
      await profileRepo.updatePushNotificationSetting(isEnabled, token);

      // 5. نحدث الداتا اللي في الشاشة (عشان الزرار ينور أو يطفي)
      final updatedProfile = currentState.profile.copyWith(isNotificationsEnabled: isEnabled);
      emit(ProfileSuccess(updatedProfile, currentState.children));

    } catch (e) {
      emit(ProfileNotificationActionError(e.toString()));
      emit(ProfileSuccess(currentState.profile, currentState.children));
    }
  }
}
