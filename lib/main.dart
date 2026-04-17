import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';

void main(){
  runApp(const SmartKids());
}
class SmartKids extends StatelessWidget{
  const SmartKids({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:RoutesManager.routes,
      initialRoute: RoutesManager.SplashRoute,
    );
  }

}