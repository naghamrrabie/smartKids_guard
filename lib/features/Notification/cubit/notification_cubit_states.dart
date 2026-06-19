import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/Notification/data/models/notification_model.dart';
import 'package:smartkids_gurad/features/Notification/domin/notification_repo.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class NotificationLoading extends NotificationState {}
class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationSuccess(this.notifications);
}
class NotificationError extends NotificationState {
  final String error;
  NotificationError(this.error);
}

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo notificationRepo;

  NotificationCubit({required this.notificationRepo}) : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    try {
      // 💡 1. بنجيب الـ ID بتاع الطفل من الخزنة (Dynamic Data)
      int? currentChildId = CacheHelper.getData(key: 'current_child_id');

      if (currentChildId == null) {
        emit(NotificationError("لا يوجد طفل مسجل لعرض الإشعارات الخاصة به."));
        return;
      }

      // 💡 2. بنبعت الـ ID للسيرفر
      final notifications = await notificationRepo.getChildNotifications(currentChildId);

      emit(NotificationSuccess(notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}