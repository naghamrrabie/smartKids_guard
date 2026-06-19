import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/my_child_model.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/profile_model.dart';

class ProfileRepo {
  final Dio dio;

  ProfileRepo({required this.dio});

  Future<ProfileResponseModel> getProfile() async {
    try {
      // الـ Interceptor اللي عملناه هيحط التوكن هنا أوتوماتيك!
      final response = await dio.get('/api/Parent/profile');

      return ProfileResponseModel.fromJson(response.data);

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
  Future<List<MyChildModel>> getMyChildren() async {
    try {
      final response = await dio.get('/api/Child/my-children');

      List<MyChildModel> children = (response.data as List)
          .map((child) => MyChildModel.fromJson(child))
          .toList();

      return children;
    } catch (e) {
      throw 'فشل في تحميل بيانات الأطفال.';
    }
  }
  Future<ProfileResponseModel> updateProfile(ProfileResponseModel updatedData) async {
    try {
      final response = await dio.put(
        '/api/Parent/profile',
        data: updatedData.toJson(), // استخدمنا الـ toJson اللي لسه عاملينه
      );

      return ProfileResponseModel.fromJson(response.data);
    }  on DioException catch (e) {
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
// ==========================================
  // دالة تفعيل/إلغاء الإشعارات وبعت التوكن للسيرفر
  // ==========================================
  Future<void> updatePushNotificationSetting(bool isEnabled, String deviceToken) async {
    try {
      await dio.put(
        '/api/Parent/set-notifications',
        data: {
          "isEnabled": isEnabled,
          "deviceToken": deviceToken, // لو قفلنا الإشعارات ممكن نبعته فاضي أو نبعت القديم
        },
      );
    } on DioException catch (e) {
      if (e.response != null) {
        throw 'حدث خطأ في الخادم: ${e.response?.statusCode}';
      } else {
        throw 'لا يوجد اتصال بالإنترنت.';
      }
    } catch (e) {
      throw 'حدث خطأ: ${e.toString()}';
    }
  }
  Future<void> uploadParentImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "Image": await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      await dio.put(
        '/api/Parent/upload-image',
        data: formData,
      );
    } on DioException catch (e) {
      throw 'فشل رفع الصورة: ${e.response?.statusCode}';
    } catch (e) {
      throw 'حدث خطأ غير متوقع أثناء رفع الصورة.';
    }
  }
  // دالة مسح صورة الأب
  Future<void> deleteParentImage() async {
    try {
      await dio.put('/api/Parent/delete-image');
    } on DioException catch (e) {
      throw 'فشل مسح الصورة: ${e.response?.statusCode}';
    } catch (e) {
      throw 'حدث خطأ غير متوقع.';
    }
  }

}
