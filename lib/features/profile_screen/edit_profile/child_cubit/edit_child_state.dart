import 'dart:io';

abstract class EditChildState {}
class EditChildInitial extends EditChildState {}
class EditChildLoading extends EditChildState {}
class EditChildSuccess extends EditChildState {
  final String message;
  EditChildSuccess(this.message);
}
class EditChildError extends EditChildState {
  final String error;
  EditChildError(this.error);
}
class EditChildImageDeleted extends EditChildState {
  final String message;
  EditChildImageDeleted(this.message);
}

// State مخصوصة عشان لما اليوزر يختار صورة، نعرضها في الـ UI فوراً قبل ما يدوس حفظ
class EditChildImagePicked extends EditChildState {
  final File image;
  EditChildImagePicked(this.image);
}