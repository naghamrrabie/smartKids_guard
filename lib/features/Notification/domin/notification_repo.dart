import 'package:dio/dio.dart';
import 'package:smartkids_gurad/features/Notification/data/models/notification_model.dart';

class NotificationRepo {
  final Dio dio;

  NotificationRepo({required this.dio});

  Future<List<NotificationModel>> getChildNotifications(int childId) async {
    try {
      final response = await dio.get('/api/Child/child-notifications/$childId');

      List<NotificationModel> notifications = (response.data as List)
          .map((item) => NotificationModel.fromJson(item))
          .toList();

      return notifications;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
      }
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          throw 'انتهت جلسة الدخول، يرجى تسجيل الدخول مجدداً.';
        } else {
          throw 'حدث خطأ في الخادم: ${e.response?.statusCode}';
        }
      } else {
        throw 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.';
      }
    } catch (e) {
      throw 'حدث خطأ: ${e.toString()}';
    }
  }
}