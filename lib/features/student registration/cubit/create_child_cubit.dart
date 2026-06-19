import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/features/student%20registration/cubit/create_child_state.dart';
import 'package:smartkids_gurad/features/student%20registration/data/model/child_models.dart';
import 'package:smartkids_gurad/features/student%20registration/domin/child_repo.dart';
// استدعي الـ Repo والـ States والـ Models

class CreateChildCubit extends Cubit<CreateChildState> {
  final ChildRepo childRepo;

  CreateChildCubit({required this.childRepo}) : super(CreateChildInitial());

  // بنحتفظ بالمدارس هنا عشان الـ UI يقراها بسهولة
  List<SchoolModel> schoolsList = [];

  // 1. جلب المدارس (هنناديها أول ما الشاشة تفتح)
  Future<void> fetchSchools() async {
    emit(GetSchoolsLoading());
    try {
      schoolsList = await childRepo.getSchools();
      emit(GetSchoolsSuccess(schoolsList));
    } catch (e) {
      emit(GetSchoolsError(e.toString()));
    }
  }

  // 2. إنشاء طفل
  Future<void> createNewChild({
    required String firstName,
    required String lastName,
    required int age,
    required int schoolId,
    required String securityKey,
  }) async {
    emit(CreateChildLoading());
    try {
      final childResponse = await childRepo.createChild(
        firstName: firstName,
        lastName: lastName,
        age: age,
        schoolId: schoolId,
        securityKey: securityKey,
      );
      emit(CreateChildSuccess(childResponse));
    } catch (e) {
      emit(CreateChildError(e.toString()));
    }
  }
}