import 'package:flutter/material.dart';
import 'package:smartkids_gurad/config/theme/theme_manager.dart';
import 'package:smartkids_gurad/core/di/di_container.dart' as di;
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
// مفتاح الطوارئ عشان نقدر ننقل بين الشاشات من غير Context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // السطر ده مهم جداً عشان نتأكد إن فلاتر جهزت كل حاجة قبل ما ننفذ أكواد الـ async اللي تحت
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // 1. تهيئة الخزنة (عشان نقدر نقرأ منها التوكن في الـ Splash)
  await CacheHelper.init();

  // 2. تهيئة الـ DI Container
  await di.setupDI();
  await _setupFirebaseMessaging();

  runApp(const SmartKids());
}

class SmartKids extends StatelessWidget {
  const SmartKids({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: RoutesManager.routes,
      initialRoute: RoutesManager.SplashRoute,
      theme: ThemeManager.light,
      navigatorKey: navigatorKey,
    );
  }
}
Future<void> _setupFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // 1. طلب الصلاحية من اليوزر (مهم جداً للأندرويد 13+ والآيفون)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ User granted permission for notifications');

    // 2. سحب التوكن بتاع الجهاز
    String? token = await messaging.getToken();
    print('🔥 My Device Token: $token');

  } else {
    print('❌ User declined or has not accepted permission');
  }
}