import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/widgets/app_top_headerr.dart';
import 'widgets/menu.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: Column(
        children: [
          AppTopHeader(
            title: 'Help&Support',
            height: 115,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _QuestionTile(
                    title: 'How Can I add my child to the app?',
                  ),
                  const SizedBox(height: 14),

                  const _QuestionTile(
                    title: 'How do I enable or disable\nnotifications?',
                  ),
                  const SizedBox(height: 14),

                  const _QuestionTile(
                    title: 'What should I do if I forget my\npassword?',
                  ),
                  const SizedBox(height: 22),

                  const Text(
                    'Contacts Support',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),

                  const _SupportCard(
                    bgColor: Color(0xFFA6E6B6),
                    borderColor: Color(0xFF2ED06E),
                    shadowColor: Color(0x332ED06E),
                    iconAsset: ImageAssets.emailSupport,
                    title: 'Email Support',
                    subtitle1: 'support@safeme.app',
                    subtitle2: "We'll respond within 24 hours",
                  ),
                  const SizedBox(height: 18),

                  const _SupportCard(
                    bgColor: Color(0xFFD8B6F5),
                    borderColor: Color(0xFFB065E8),
                    shadowColor: Color(0x33B065E8),
                    iconAsset: ImageAssets.phoneSupport,
                    title: 'Phone Support',
                    subtitle1: 'support@safeme.app',
                    subtitle2: "We'll respond within 24 hours",
                  ),
                  const SizedBox(height: 22),

                  const _QuickTipsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionTile extends StatelessWidget {
  final String title;

  const _QuestionTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFDDEAF4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.help_outline,
            color: ColorsManager.bluee,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.2,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 28,
          ),
        ],
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final Color shadowColor;
  final String iconAsset;
  final String title;
  final String subtitle1;
  final String subtitle2;

  const _SupportCard({
    required this.bgColor,
    required this.borderColor,
    required this.shadowColor,
    required this.iconAsset,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                iconAsset,
                width: 38,
                height: 38,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            subtitle1,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle2,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickTipsCard extends StatelessWidget {
  const _QuickTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFD2D8D5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFA9AEAB),
          width: 1.2,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '💡',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 8),
              Text(
                'Quick Tips',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '• Keep your app updated for the\n'
                'latest features\n'
                '• Test the SOS button with your\n'
                'child monthly\n'
                '• Review and update emergency\n'
                'contacts regularly\n'
                '• Enable location services for\n'
                'accurate tracking',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}