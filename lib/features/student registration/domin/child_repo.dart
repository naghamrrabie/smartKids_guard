import 'package:dio/dio.dart';
import 'package:smartkids_gurad/features/student%20registration/data/model/child_models.dart';
// استدعي مسار الـ child_models.dart هنا

class ChildRepo {
  final Dio dio;

  ChildRepo({required this.dio});

  // ==========================================
  // 1. جلب قائمة المدارس
  // ==========================================
  Future<List<SchoolModel>> getSchools() async {
    try {
      final response = await dio.get('/api/school/dropdown');

      // بنحول الـ List اللي راجعة لـ List<SchoolModel>
      List<SchoolModel> schools = (response.data as List)
          .map((school) => SchoolModel.fromJson(school))
          .toList();

      return schools;
    } catch (e) {
      throw 'فشل في تحميل قائمة المدارس، يرجى المحاولة لاحقاً.';
    }
  }

  // ==========================================
  // 2. إضافة طفل جديد
  // ==========================================
  Future<ChildResponseModel> createChild({
    required String firstName,
    required String lastName,
    required int age,
    required int schoolId,
    required String securityKey,
  }) async {
    try {
      final response = await dio.post(
        '/api/Child/create-child',
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "age": age,
          "schoolId": schoolId,
          "securityKey": securityKey,
        },
      );

      return ChildResponseModel.fromJson(response.data);

    } on DioException catch (e) {
      if (e.response != null) {
        // هندلة الـ 400 (Bad Request)
        if (e.response?.statusCode == 400) {
          final errors = e.response?.data['errors'];
          if (errors != null && errors is List && errors.isNotEmpty) {
            throw errors.first.toString(); // بنرجع أول إيرور بس للمستخدم
          }
          throw 'تأكد من إدخال جميع البيانات بشكل صحيح.';
        }
        // هندلة الـ 500 (Server Error / Duplicate Key)
        else if (e.response?.statusCode == 500) {
          throw 'رمز الحماية (Security Key) مستخدم بالفعل لطفل آخر، أو حدث خطأ في الخادم.';
        } else {
          throw 'حدث خطأ: ${e.response?.statusCode}';
        }
      } else {
        throw 'تحقق من اتصالك بالإنترنت';
      }
    } catch (e) {
      throw 'حدث خطأ غير متوقع: ${e.toString()}';
    }
  }
}