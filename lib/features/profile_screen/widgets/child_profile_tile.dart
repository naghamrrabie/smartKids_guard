import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/profile_screen/cubit/profile_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/data/models/my_child_model.dart';

class ChildProfileTile extends StatelessWidget {
  final MyChildModel child; // 💡 استقبلنا بيانات الطفل الواحد

  const ChildProfileTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getData(key: 'token');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.only(bottom: 12), // عشان لو في كذا طفل تحت بعض
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          /// صورة الطفل (لو موجودة)
          ClipOval(
            child: child.imageUrl != null
                ? Image.network(
              child.imageUrl!,
              width: 62,
              height: 62,
              fit: BoxFit.cover,
              headers: token != null ? {'Authorization': 'Bearer $token'} : null,
              errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
            )
                : _buildFallbackAvatar(),
          ),

          const SizedBox(width: 14),

          /// بيانات الطفل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  child.fullName, // 💡 الاسم من الـ API
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  'Age ${child.age ?? '--'} . ${child.school ?? 'Unknown School'}', // 💡 العمر والمدرسة
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorsManager.greyText),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          /// زرار الـ Edit
          Column(
            children: [
              InkWell(
                onTap: () {
                  // 💡 هنا هنباصي الداتا بتاعت الطفل لشاشة الـ EditChildProfile
                  Navigator.pushNamed(
                    context,
                    RoutesManager.editChildProfile,
                    arguments: child, // باصينا الـ Object كامل
                  ).then((value) {
                    // عشان لو عدلنا حاجة، الشاشة دي تعمل Refresh لما نرجع
                    context.read<ProfileCubit>().getProfile();
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text('Edit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ColorsManager.bluee)),
                ),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.chevron_right, size: 28, color: ColorsManager.greyText),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: 62, height: 62,
      color: Colors.grey[300],
      child: const Icon(Icons.person, size: 30, color: Colors.grey),
    );
  }
}