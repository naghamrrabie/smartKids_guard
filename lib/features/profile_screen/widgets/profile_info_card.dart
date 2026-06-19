import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/profile_screen/cubit/profile_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/profile_model.dart';

class ProfileInfoCard extends StatelessWidget {
  final ProfileResponseModel profileData; // استقبلنا الداتا هنا

  const ProfileInfoCard({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    // هنجيب التوكن من الخزنة عشان نباصيه للصورة
    String? token = CacheHelper.getData(key: 'token');

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          Row(
            children: [
              /// صورة البروفايل (من الـ API)
              ClipOval(
                child: Image.network(
                  profileData.imageUrl,
                  width: 78,
                  height: 78,
                  fit: BoxFit.cover,
                  // 💡 هنا السحر: بنبعت التوكن للسيرفر عشان يسمحلنا نعرض الصورة!
                  headers: token != null ? {'Authorization': 'Bearer $token'} : null,
                  // لو الصورة فيها مشكلة أو لسه بتحمل نعرض Icon مؤقتة
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 78,
                    height: 78,
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              /// بيانات المستخدم (ديناميك من الـ API)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileData.fullName, // الاسم من الـ Model
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // عشان لو الاسم طويل
                    ),
                    const SizedBox(height: 6),
                    Text(
                      profileData.email, // الإيميل من الـ Model
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.greyText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profileData.phoneNumber, // الموبايل من الـ Model
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          /// زرار Edit Profile
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutesManager.editProfileScreen,
                arguments: profileData, // بنباصي الداتا القديمة هنا
              ).then((value) {
                // 💡 التريكة: السطر ده هيخلي الشاشة تطلب الداتا تاني أول ما نرجع من الـ Edit
                context.read<ProfileCubit>().getProfile();
              });
            },
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: ColorsManager.blue,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),        ],
      ),
    );
  }
}