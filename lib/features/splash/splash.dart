import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';

class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     navigate();
  }
  void navigate(){
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed
        (context, RoutesManager.onBoardingRoute);
    });
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       width: double.infinity,
       height: double.infinity,
       decoration:  BoxDecoration(
         gradient: ColorsManager.blue,
       ),
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Image.asset(ImageAssets.SplashLogo),
             SizedBox(height: 20),
             Text("Smartkids Gurad",
               style: TextStyle(
                 fontSize: 36,
                 fontWeight: FontWeight.bold,
                 fontFamily: "serif",
                 color: Colors.white,
               ),
             ),

           ],
         ),
       ),
       ),
   );
  }
}