import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/home/data/models/home_child_model.dart';
// ⚠️ استدعي الـ HomeChildModel

class ChildCard extends StatelessWidget {
  final HomeChildModel childData; // استقبلنا الداتا

  const ChildCard({super.key, required this.childData});

  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getData(key: 'token');

    // تحديد لون النقطة بناءً على حالة الطفل
    Color stateColor = childData.childState.toLowerCase() == 'normal'
        ? const Color(0xFF1DB954) // أخضر
        : Colors.red; // أحمر لأي حالة تانية زي Offline

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipOval(
                child: childData.imageUrl != null
                    ? Image.network(
                  childData.imageUrl!,
                  width: 78,
                  height: 78,
                  fit: BoxFit.cover,
                  headers: token != null ? {'Authorization': 'Bearer $token'} : null,
                  errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
                )
                    : _buildFallbackAvatar(), // لو راجعة بـ null نعرض أيكونة رمادي
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: stateColor, // 💡 اللون الديناميك
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(childData.fullName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black)),
                const SizedBox(height: 4),
                Text(childData.schoolName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorsManager.greyText)),
                const SizedBox(height: 3),
                Text('Student ID: ${childData.studentId}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorsManager.greyText)),
                const SizedBox(height: 3),
                if (childData.grade != null) // نعرض الجريد بس لو مش بـ null
                  Text(childData.grade!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorsManager.greyText)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت بديلة لو مفيش صورة
  Widget _buildFallbackAvatar() {
    return Container(
      width: 78,
      height: 78,
      color: Colors.grey[300],
      child: const Icon(Icons.person, size: 40, color: Colors.grey),
    );
  }
}