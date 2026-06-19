import 'package:dio/dio.dart';
import 'package:smartkids_gurad/core/network/dio_factory.dart';
import 'package:smartkids_gurad/features/login/data/models/login_response_model.dart';
// حط مسار الـ DioClient والـ Model بتاعك هنا

class LoginRepo {
final Dio dio;
LoginRepo({required this.dio});
  Future<LoginResponseModel> login(String phone, String password) async {
    try {
      final response = await dio.post(
        '/api/Account/login', // مش محتاج تكتب الـ baseUrl كله عشان إنت معرفه في الـ DioClient
        data: {
          "phoneNumber": phone,
          "password": password,
        },
      );

      // لو الـ Request نجح (Status 200)
      return LoginResponseModel.fromJson(response.data);

    } on DioException catch (e) {
      // 1. هندلة مشاكل الإنترنت (No Internet)
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
      }

      // 2. هندلة الـ Errors اللي راجعة من السيرفر
      if (e.response != null) {
        if (e.response?.statusCode == 400) {
          // Bad Request (الباسورد غلط أو الموبايل مش مصري)
          // ممكن تقرأ الـ errors من الـ response او تثبت رسالة مخصصة زي ما طلبت
          throw 'برجاء التحقق من رقم الهاتف أو كلمة المرور.';
        } else if (e.response?.statusCode == 500) {
          // Internal Server Error
          throw 'حدث خطأ في الخادم (Server Error)، يرجى المحاولة لاحقاً.';
        } else {
          throw 'حدث خطأ غير متوقع: ${e.response?.statusCode}';
        }
      } else {
        throw 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.';
      }
    } catch (e) {
      throw 'حدث خطأ: ${e.toString()}';
    }
  }
}