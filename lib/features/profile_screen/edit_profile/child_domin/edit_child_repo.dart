import 'dart:io';
import 'package:dio/dio.dart';

class EditChildRepo {
  final Dio dio;
  EditChildRepo({required this.dio});

  // 1. تحديث البيانات
  Future<void> updateChildData({
    required int childId,
    required String fullName,
    required int age,
    String? birthDate, // خليناه Nullable
    String? grade,
  }) async {
    try {
      await dio.put(
        '/api/Child/update-child-data',
        data: {
          "childId": childId,
          "fullName": fullName,
          "age": age,
          // 💡 التريكة: لو التاريخ فاضي نبعته null صريح مش string فاضي عشان إيرور الـ DateOnly
          "birthDate": (birthDate == null || birthDate.isEmpty) ? null : birthDate,
          "grade": (grade == null || grade.isEmpty) ? null : grade,
        },
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final errors = e.response?.data['errors'];
        if (errors != null && errors is List && errors.isNotEmpty) {
          throw errors.first.toString();
        }
        throw 'تأكد من إدخال البيانات بشكل صحيح.';
      } else {
        throw 'حدث خطأ في الخادم: ${e.response?.statusCode}';
      }
    } catch (e) {
      throw 'تحقق من اتصالك بالإنترنت';
    }
  }

  // 2. رفع الصورة
  Future<void> uploadChildImage({
    required int childId,
    required File imageFile,
  }) async {
    try {
      String fileName = imageFile.path.split('/').last;

      // تجهيز الـ FormData
      FormData formData = FormData.fromMap({
        "childId": childId,
        "Image": await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      await dio.put(
        '/api/Child/upload-image',
        data: formData,
      );
    } catch (e) {
      throw ' فشل رفع الصورة.';
    }
  }
  // 3. مسح الصورة
  Future<void> deleteChildImage(int childId) async {
    try {
      await dio.delete('/api/Child/delete-child-image/$childId');
    } catch (e) {
      throw 'فشل مسح الصورة، يرجى المحاولة لاحقاً.';
    }
  }

}