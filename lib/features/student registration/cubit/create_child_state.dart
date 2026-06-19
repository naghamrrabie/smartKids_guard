// استدعي الـ Models

import 'package:smartkids_gurad/features/student%20registration/data/model/child_models.dart';

abstract class CreateChildState {}

class CreateChildInitial extends CreateChildState {}

// --- حالات جلب المدارس ---
class GetSchoolsLoading extends CreateChildState {}
class GetSchoolsSuccess extends CreateChildState {
  final List<SchoolModel> schools;
  GetSchoolsSuccess(this.schools);
}
class GetSchoolsError extends CreateChildState {
  final String error;
  GetSchoolsError(this.error);
}

// --- حالات إنشاء طفل ---
class CreateChildLoading extends CreateChildState {}
class CreateChildSuccess extends CreateChildState {
  final ChildResponseModel child;
  CreateChildSuccess(this.child);
}
class CreateChildError extends CreateChildState {
  final String error;
  CreateChildError(this.error);
}