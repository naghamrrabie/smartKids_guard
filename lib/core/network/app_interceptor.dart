import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/main.dart'; // عشان نوصل للـ navigatorKey

class AppInterceptor extends Interceptor {
  final Dio dio;

  AppInterceptor(this.dio);

  // ==========================================
  // 1. الدالة دي بتشتغل مع أي Request طالع
  // ==========================================
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    if (options.path.contains('login') || options.path.contains('register')) {
      return super.onRequest(options, handler);
    }

    // غير كده، هات التوكن وحطه
    String? token = CacheHelper.getData(key: 'token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return super.onRequest(options, handler);
  }

  // ==========================================
  // 2. الدالة دي بتشتغل لو حصل Error راجع من السيرفر
  // ==========================================
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // لو الخطأ 401 (Unauthorized) يعني التوكن وقته خلص
    if (err.response?.statusCode == 401) {
      String? refreshToken = CacheHelper.getData(key: 'refreshToken');

      if (refreshToken != null) {
        try {
          // هنعمل Dio جديد خالص عشان نضرب بيه API التجديد من غير ما نخش في (لوب لا نهائية)
          final refreshDio = Dio();

          final response = await refreshDio.post(
            'https://smartkidsguard-production.up.railway.app/api/Account/refresh', // ⚠️ حط الـ Endpoint الصح هنا
            data: {
              "token": refreshToken, // زي ما وريتني في الصورة
            },
          );

          if (response.statusCode == 200) {
            // التجديد نجح! نجيب التوكنات الجديدة
            String newToken = response.data['token'];
            String newRefreshToken = response.data['refreshToken'];

            // نحفظهم في الخزنة
            await CacheHelper.saveData(key: 'token', value: newToken);
            await CacheHelper.saveData(key: 'refreshToken', value: newRefreshToken);

            // نعدل الـ Request القديم اللي فشل بالتوكن الجديد
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

            // نعيد إرسال الـ Request القديم تاني وكأن شيئاً لم يكن
            final cloneReq = await dio.fetch(err.requestOptions);
            return handler.resolve(cloneReq);
          }
        } catch (e) {
          // لو التجديد فشل (الـ Refresh Token نفسه خلص أو النت قطع وقتها)
          _performLogout();
        }
      } else {
        // مفيش Refresh Token أصلاً في الخزنة
        _performLogout();
      }
    }

    return super.onError(err, handler);
  }

  // ==========================================
  // 3. دالة الطرد (Force Logout)
  // ==========================================
  void _performLogout() {
    // نمسح التوكنات القديمة
    CacheHelper.removeData(key: 'token');
    CacheHelper.removeData(key: 'refreshToken');

    // نستخدم مفتاح الطوارئ عشان نروح للوجين ونفضي الـ Stack
    if (navigatorKey.currentContext != null) {
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RoutesManager.login,
            (route) => false,
      );
    }
  }
}