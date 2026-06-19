import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/widgets/app_top_headerr.dart';
import 'widgets/menu.dart';

class AboutSmartKidsGuard extends StatelessWidget {
  const AboutSmartKidsGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: Column(
        children: [
          AppTopHeader(
            title: 'About SmartKids Guard',
            height: 120,
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (_) => const MenuScreen(),
                );
              },
              icon: Image.asset(
                ImageAssets.rivetIconsSettings,
                width: 26,
                height: 26,
                color: Colors.black,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About SmartKids Guard',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  Text(
                    'Safe Me is a smart application designed to\n'
                        'keep every school trip safe and connected.\n'
                        'It allows parents and schools to track\n'
                        'the bus in real time and receive instant alerts\n'
                        'in case of any issues.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  SizedBox(height: 28),

                  Text(
                    'Our Vision',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  Text(
                    'To make every student’s journey to and from\n'
                        'school completely safe and worry-free.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  SizedBox(height: 28),

                  Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  Text(
                    'To provide a smart and easy tool that\n'
                        'connects schools, drivers, and parents —\n'
                        'ensuring children’s safety at all times.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  SizedBox(height: 28),

                  Text(
                    'Core Values',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  Text(
                    '- Safety First\n'
                        '- Transparency and Trust\n'
                        '- Responsibility\n'
                        '- Innovation for a Better Experience',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),

                  SizedBox(height: 28),

                  Text(
                    'Key Features',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6),

                  Text(
                    '- Live bus tracking.\n'
                        '- Instant alerts for delays or issues.\n'
                        '- Quick contact with school security or the driver.\n'
                        '- Simple and user-friendly interface.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}