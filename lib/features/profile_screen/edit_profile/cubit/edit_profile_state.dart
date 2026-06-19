import 'dart:io';

abstract class EditProfileState {}
class EditProfileInitial extends EditProfileState {}
class EditProfileLoading extends EditProfileState {}
class EditProfileSuccess extends EditProfileState {}
class EditProfileError extends EditProfileState {
  final String error;
  EditProfileError(this.error);
}
class EditProfileImagePicked extends EditProfileState {
  final File image;
  EditProfileImagePicked(this.image);
}
class EditProfileImageDeleted extends EditProfileState {
  final String message;
  EditProfileImageDeleted(this.message);
}