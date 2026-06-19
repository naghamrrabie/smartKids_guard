
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/login/login.dart';


class Onboarding extends StatelessWidget {
 Onboarding({super.key});
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.of(context).pushReplacementNamed(RoutesManager.login);
      }
    });
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
      const bodyStyle = TextStyle(fontSize: 19.0);

      const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: ColorsManager.lightBlue,
        imagePadding: EdgeInsets.zero,
      );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: ColorsManager.lightBlue,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "Monitor You Child",
          body: "Now you can monitor your Child any time right from your mobile",

          image: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Image.asset(
                ImageAssets.introLogo1,
              ),
            ),
          ),

          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              color: Colors.blue,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),

            bodyTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),

            // يخلي الصورة فوق والكلام تحتها بشكل طبيعي
            imageFlex: 3,
            bodyFlex: 2,

            // المسافات
            titlePadding: EdgeInsets.only(top: 10),
            bodyPadding: EdgeInsets.only(top: 4),

            imagePadding: EdgeInsets.only(top: 20),

            contentMargin: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        PageViewModel(
          title: "About The Sysem",
          body: "We are ensure safety of the students by"
              " making their parents aware about the "
              "various important  status.",

          image: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Image.asset(
                ImageAssets.introLogo2,
              ),
            ),
          ),

          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              color: Colors.blue,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),

            bodyTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),

            // يخلي الصورة فوق والكلام تحتها بشكل طبيعي
            imageFlex: 3,
            bodyFlex: 2,

            // المسافات
            titlePadding: EdgeInsets.only(top: 10),
            bodyPadding: EdgeInsets.only(top: 4),

            imagePadding: EdgeInsets.only(top: 20),

            contentMargin: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
        PageViewModel(
          title: "Technolgy Used",
          body: "By using RFID technology, it is easy track "
                 "the student thus enhances the security "
                  "and safety in selected zone.",

          image: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Image.asset(
                ImageAssets.introLogo3,
              ),
            ),
          ),

          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              color: Colors.blue,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),

            bodyTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),

            // يخلي الصورة فوق والكلام تحتها بشكل طبيعي
            imageFlex: 3,
            bodyFlex: 2,

            // المسافات
            titlePadding: EdgeInsets.only(top: 10),
            bodyPadding: EdgeInsets.only(top: 4),

            imagePadding: EdgeInsets.only(top: 20),

            contentMargin: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),


      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      //showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
     // showBackButton: false,
      //rtl: true, // Display as right-to-left
      //skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      showBackButton: true,
      back: Text('Back',style: TextStyle(fontSize:16,
          fontWeight: FontWeight.bold ,
          color:ColorsManager.bluee
         ),),
      showNextButton: true,
      next: Text('Next',style: TextStyle(fontSize:16,
          fontWeight: FontWeight.bold ,
          color:ColorsManager.bluee
           ),),
      showDoneButton: true,
      done: Text('Finish',style: TextStyle(fontSize:16,
          fontWeight: FontWeight.bold ,
          color:ColorsManager.bluee
           ),),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),

      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: ColorsManager.bluee,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  
}