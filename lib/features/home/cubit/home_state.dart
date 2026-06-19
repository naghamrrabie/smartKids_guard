import 'package:smartkids_gurad/features/home/data/models/home_child_model.dart';

abstract class HomeState {}
class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final List<HomeChildModel> children;
  HomeSuccess(this.children);
}
class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}