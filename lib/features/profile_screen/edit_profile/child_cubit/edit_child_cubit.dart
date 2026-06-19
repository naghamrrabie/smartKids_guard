import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/child_cubit/edit_child_state.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/child_domin/edit_child_repo.dart';

class EditChildCubit extends Cubit<EditChildState> {
  final EditChildRepo editChildRepo;

  EditChildCubit({required this.editChildRepo}) : super(EditChildInitial());

  File? selectedImage; // هنخزن فيها الصورة لو اليوزر اختار حاجة جديدة

  // الدالة دي الـ UI هيناديها لما اليوزر يختار صورة من الاستوديو أو الكاميرا
  bool isImageDeleted = false;
  void setImage(File image) {
    selectedImage = image;
    isImageDeleted = false;
    emit(EditChildImagePicked(image));
  }
  Future<void> deleteChildImage(int childId) async {
    emit(EditChildLoading()); // عشان نلفف زرار الحفظ لحد ما يخلص
    try {
      await editChildRepo.deleteChildImage(childId);

      selectedImage = null; // نفضي الصورة لو كان مختار واحدة
      isImageDeleted = true; // ندي إشارة للـ UI يعرض الأيقونة الفاضية

      emit(EditChildImageDeleted('تم مسح الصورة بنجاح!'));
    } catch (e) {
      emit(EditChildError(e.toString()));
    }
  }

  // الدالة الرئيسية للحفظ
  Future<void> updateChildProfile({
    required int childId,
    required String fullName,
    required int age,
    String? birthDate,
    String? grade,
  }) async {
    emit(EditChildLoading());
    try {
      // 1. تحديث البيانات الأول
      await editChildRepo.updateChildData(
        childId: childId,
        fullName: fullName,
        age: age,
        birthDate: birthDate,
        grade: grade,
      );

      // 2. لو اليوزر كان اختار صورة جديدة، نرفعها
      if (selectedImage != null) {
        await editChildRepo.uploadChildImage(childId: childId, imageFile: selectedImage!);
      }

      emit(EditChildSuccess('Child profile updated successfully!'));
    } catch (e) {
      emit(EditChildError(e.toString()));
    }
  }
}