import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/features/home/widgets/bottom_nav_bar.dart';
import 'package:smartkids_gurad/features/profile_screen/widgets/menu.dart';

/// =======================================================
/// شاشة EditChildProfile
/// الشاشة دي بتعرض:
/// - Header فوق
/// - كارت صورة الطفل
/// - قسم البيانات الشخصية
/// - زرار Save Changes
/// - Bottom Navigation Bar
/// =======================================================
class EditChildProfile extends StatelessWidget {
  const EditChildProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// لون خلفية الشاشة
      backgroundColor: ColorsManager.lightBlue,

      /// بنستخدم نفس الـ BottomNavBar القديمة
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

      /// ما استخدمناش SafeArea على الشاشة كلها
      /// عشان الهيدر يطلع لأول الشاشة
      body: Column(
        children: [
          /// =================================================
          /// Header
          /// =================================================
          const _EditChildProfileHeader(),

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
                  /// كارت صورة الطفل
                  /// ===========================================
                  const _ChildPhotoCard(),
                  const SizedBox(height: 22),

                  /// ===========================================
                  /// عنوان Personal information
                  /// ===========================================
                  const Text(
                    'Personal information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// ===========================================
                  /// كارت البيانات الشخصية
                  /// ===========================================
                  const _ChildInformationCard(),
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
/// Header الخاص بشاشة EditChildProfile
/// =======================================================
class _EditChildProfileHeader extends StatelessWidget {
  const _EditChildProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ارتفاع الهيدر dynamic حسب الـ status bar
      height: MediaQuery.of(context).padding.top + 90,
      width: double.infinity,
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
/// كارت صورة الطفل
/// فيه:
/// - صورة الطفل
/// - أيقونة الكاميرا
/// - اسم الطفل
/// - Student ID
/// =======================================================
class _ChildPhotoCard extends StatelessWidget {
  const _ChildPhotoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
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
                width: 118,
                height: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.babyPhoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// أيقونة الكاميرا
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  width: 52,
                  height: 52,
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
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// اسم الطفل
          const Text(
            'Eman Ahmed',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          /// رقم الطالب
          const Text(
            'Student ID: LES-2024-0892',
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
class _ChildInformationCard extends StatelessWidget {
  const _ChildInformationCard();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Full Name
          _ProfileInputField(
            iconAsset: ImageAssets.icName2,
            label: 'Full Name',
            value: 'Eman Ahmed Mohamed',
          ),
          SizedBox(height: 16),

          /// Date of birth + Age
          Row(
            children: [
              Expanded(
                child: _SmallProfileInputField(
                  iconAsset: ImageAssets.icDate,
                  label: 'Date of birth',
                  value: '5/3/2015',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _SmallProfileInputField(
                  label: 'Age',
                  value: '12',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          /// School name
          _ProfileInputField(
            iconAsset: ImageAssets.icName2,
            label: 'School name',
            value: 'Modern Futsure School',
          ),
          SizedBox(height: 16),

          /// Grade
          _OnlyLabelInputField(
            label: 'Grade',
            value: 'Grade 5-A',
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// حقل كبير فيه:
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
        /// الأيقونة + اسم الحقل
        Row(
          children: [
            Image.asset(
              iconAsset,
              width: 24,
              height: 24,
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
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
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
/// حقل صغير
/// استخدمناه في Date of birth و Age
/// =======================================================
class _SmallProfileInputField extends StatelessWidget {
  final String? iconAsset;
  final String label;
  final String value;

  const _SmallProfileInputField({
    this.iconAsset,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// لو فيه أيقونة نعرضها
        Row(
          children: [
            if (iconAsset != null) ...[
              Image.asset(
                iconAsset!,
                width: 22,
                height: 22,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
            ],
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

        /// البوكس الصغير
        Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
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
/// حقل بدون أيقونة
/// استخدمناه في Grade
/// =======================================================
class _OnlyLabelInputField extends StatelessWidget {
  final String label;
  final String value;

  const _OnlyLabelInputField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// اسم الحقل فقط
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 10),

        /// البوكس
        Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
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
/// زرار Save Changes
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