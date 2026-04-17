import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/features/home/widgets/bottom_nav_bar.dart';
import 'package:smartkids_gurad/features/profile_screen/widgets/menu.dart';

/// =======================================================
/// شاشة Edit Profile
/// الشاشة دي بتعرض:
/// - Header فوق
/// - كارت صورة البروفايل
/// - قسم البيانات الشخصية
/// - زرار Save Changes
/// - Bottom Navigation Bar
/// =======================================================
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// لون خلفية الشاشة
      backgroundColor: ColorsManager.lightBlue,

      /// ===================================================
      /// Bottom Navigation Bar
      /// currentIndex = 3 لأننا داخل جزء الـ Profile
      /// ===================================================
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.homeScreen,
                  (route) => false,
            );
          } else if (i == 3) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.profileScreen,
                  (route) => false,
            );
          }
        },
      ),

      /// ===================================================
      /// ما استخدمناش SafeArea على الشاشة كلها
      /// عشان الهيدر يطلع لأول الشاشة
      /// ===================================================
      body: Column(
        children: [
          /// =================================================
          /// Header
          /// =================================================
          const _EditProfileHeader(),

          /// =================================================
          /// باقي المحتوى
          /// SingleChildScrollView عشان مايحصلش overflow
          /// =================================================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===========================================
                  /// كارت صورة البروفايل
                  /// ===========================================
                  const _ProfilePhotoCard(),
                  const SizedBox(height: 26),

                  /// ===========================================
                  /// عنوان Personal information
                  /// ===========================================
                  const Text(
                    'Personal information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// ===========================================
                  /// كارت البيانات الشخصية
                  /// ===========================================
                  const _PersonalInformationCard(),
                  const SizedBox(height: 34),

                  /// ===========================================
                  /// زرار Save Changes
                  /// ===========================================
                  const _SaveChangesButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// Header الخاص بشاشة Edit Profile
/// =======================================================
class _EditProfileHeader extends StatelessWidget {
  const _EditProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ارتفاع الهيدر dynamic عشان يناسب الـ status bar
      height: MediaQuery.of(context).padding.top + 90,
      width: double.infinity,

      /// شكل الهيدر
      decoration: BoxDecoration(
        gradient: ColorsManager.blue,
      ),

      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Row(
            children: [
              /// زرار الرجوع
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 28,
                ),
              ),

              const SizedBox(width: 4),

              /// عنوان الصفحة
              const Expanded(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              /// زرار المينيو
              IconButton(
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
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
              /// كارت صورة البروفايل
/// فيه:
/// - الصورة
                    /// - أيقونة الكاميرا
           /// - عنوانProfile Photo
                      /// - نص توضيحي
/// =======================================================
class _ProfilePhotoCard extends StatelessWidget {
  const _ProfilePhotoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          /// الصورة + دائرة الكاميرا
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.imageProfile),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// أيقونة الكاميرا
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      ImageAssets.icCamera,
                      width: 55,
                      height: 55,

                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// عنوان الصورة
          const Text(
            'Profile Photo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          /// النص التوضيحي
          const Text(
            'Click the camera icon to change your photo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorsManager.greyText,
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// كارت البيانات الشخصية
/// =======================================================
class _PersonalInformationCard extends StatelessWidget {
  const _PersonalInformationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        children: [
          /// First name
          _ProfileInputField(
            iconAsset: ImageAssets.icName2,
            label: 'First name',
            value: 'Mona Mohamed',
          ),
          SizedBox(height: 16),

          /// Email
          _ProfileInputField(
            iconAsset: ImageAssets.icEmail2,
            label: 'Email',
            value: 'Hti@gmail..com',
          ),
          SizedBox(height: 16),

          /// Home Address
          _ProfileInputField(
            iconAsset: ImageAssets.icHome2,
            label: 'Home Address',
            value: '32Pyramids,Fasil',
          ),
          SizedBox(height: 16),

          /// Relation
          _ProfileInputField(
            iconAsset: ImageAssets.icRelation,
            label: 'Relation',
            value: 'Father',
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// Widget مسؤول عن عنصر إدخال واحد
/// فيه:
/// - أيقونة
/// - Label
/// - Box شبه TextField
/// =======================================================
class _ProfileInputField extends StatelessWidget {
  final String iconAsset;
  final String label;
  final String value;

  const _ProfileInputField({
    required this.iconAsset,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// الصف اللي فيه الأيقونة + اسم الحقل
        Row(
          children: [
            Image.asset(
              iconAsset,
              width: 26,
              height: 26,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// البوكس اللي فيه القيمة
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black,
              width: 0.9,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9A9A9A),
            ),
          ),
        ),
      ],
    );
  }
}

       /// =======================================================
                  /// زرا Save Changes
      /// =======================================================
class _SaveChangesButton extends StatelessWidget {
  const _SaveChangesButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        height: 58,
        decoration: BoxDecoration(
          gradient: ColorsManager.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'Save Changes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}