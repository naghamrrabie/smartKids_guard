import 'package:smartkids_gurad/features/profile_screen/data/models/my_child_model.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/profile_model.dart';

abstract class ProfileState {}
class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileSuccess extends ProfileState {
  final ProfileResponseModel profile;
  final List<MyChildModel> children; // 💡 ضفنا اللستة هنا
  ProfileSuccess(this.profile, this.children);
}class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}
// ضيف الكلاس ده تحت خالص في ملف الـ States
class ProfileNotificationActionError extends ProfileState {
  final String error;
  ProfileNotificationActionError(this.error);
}