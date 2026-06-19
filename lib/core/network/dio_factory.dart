import 'package:dio/dio.dart';
import 'package:smartkids_gurad/core/network/app_interceptor.dart'; // تأكد من مسار الانترسيبتور بتاعك

class DioFactory {
  // دالة عادية جداً مش static singleton
  Dio getDio() {
    // 1. نكريت الـ Dio الأول
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://smartkidsguard-production.up.railway.app',
        receiveTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          // شيلنا كومنت التوكن من هنا لأن الانترسيبتور هو اللي هيتكفل بيه
        },
      ),
    );

    // 2. نربط الـ Interceptor بتاعنا بالـ Dio
    dio.interceptors.add(AppInterceptor(dio));

    // 3. (اختياري بس مهم جداً) نضيف LogInterceptor عشان يطبعلك شكل الـ Requests والرد بتاع السيرفر في الكونسول تحت وأنت شغال
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );

    // 4. نرجع الـ Dio بعد ما جهزناه
    return dio;
  }
}