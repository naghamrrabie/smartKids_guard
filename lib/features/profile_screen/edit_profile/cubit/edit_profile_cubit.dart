import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/profile_model.dart';
import 'package:smartkids_gurad/features/profile_screen/domin/profile_repo.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepo profileRepo;

  EditProfileCubit({required this.profileRepo}) : super(EditProfileInitial());
  bool isImageDeleted = false;
  File? selectedImage;
  void setImage(File image) {
    selectedImage = image;
    isImageDeleted = false; // نلغي المسح لو كان داس مسح وبعدين غير رأيه
    emit(EditProfileImagePicked(image));
  }
  Future<void> deleteProfileImage() async {
    emit(EditProfileLoading());
    try {
      await profileRepo.deleteParentImage();
      selectedImage = null; // 💡 نفضي الصورة
      isImageDeleted = true;
      emit(EditProfileImageDeleted('تم مسح الصورة بنجاح!'));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
  Future<void> updateProfileData(ProfileResponseModel currentData, {
    required String fullName,
    required String email,
    required String address,
    required String relation,
  }) async {
    emit(EditProfileLoading());
    try {
      // بنستخدم copyWith عشان نحافظ على باقي الداتا زي الصورة ورقم الموبايل
      final updatedModel = currentData.copyWith(
        fullName: fullName,
        email: email,
        address: address,
        relation: relation,
      );

      await profileRepo.updateProfile(updatedModel);
      if (selectedImage != null) {
        await profileRepo.uploadParentImage(selectedImage!);
      }
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}