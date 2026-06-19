import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // ⚠️ لازم تكون مسطب الباكدج دي
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/home/widgets/bottom_nav_bar.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/child_cubit/edit_child_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/child_cubit/edit_child_state.dart';
import 'package:smartkids_gurad/features/profile_screen/widgets/menu.dart';

import 'package:smartkids_gurad/features/profile_screen/data/models/my_child_model.dart';

class EditChildProfile extends StatefulWidget {
  final MyChildModel childData; // الداتا اللي جاية من الشاشة اللي قبلها

  const EditChildProfile({super.key, required this.childData});

  @override
  State<EditChildProfile> createState() => _EditChildProfileState();
}

class _EditChildProfileState extends State<EditChildProfile> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController birthDateController;
  late TextEditingController gradeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.childData.fullName);
    ageController = TextEditingController(text: widget.childData.age?.toString() ?? '');

    // الفورمات جاي YYYY-MM-DD
    String formattedDate = widget.childData.birthDate ?? '';
    // لو الباك إند باعت وقت مع التاريخ نقطعه
    if (formattedDate.contains('T')) {
      formattedDate = formattedDate.split('T')[0];
    }
    birthDateController = TextEditingController(text: formattedDate);
    gradeController = TextEditingController(text: widget.childData.grade ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    birthDateController.dispose();
    gradeController.dispose();
    super.dispose();
  }

  // 💡 دالة اختيار التاريخ
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // أقل سنة
      lastDate: DateTime.now(),  // مفيش طفل هيتولد في المستقبل
    );
    if (picked != null) {
      setState(() {
        // تنسيق التاريخ لـ YYYY-MM-DD عشان الباك إند ميضربش
        birthDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  // 💡 دالة اختيار الصورة
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null && context.mounted) {
      // بنبعت الصورة للـ Cubit
      context.read<EditChildCubit>().setImage(File(pickedFile.path));
    }
  }

  // 💡 شيت اختيار مصدر الصورة (كاميرا ولا استوديو)
  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: ColorsManager.bluee),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(context, ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: ColorsManager.bluee),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(context, ImageSource.camera);
              },
            ),
            // 💡 زرار المسح الجديد
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Photo', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).pop();
                context.read<EditChildCubit>().deleteChildImage(widget.childData.id);
              },
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesManager.homeScreen, (route) => false);
          } else if (i == 3) Navigator.pushNamedAndRemoveUntil(context, RoutesManager.profileScreen, (route) => false);
        },
      ),
      body: Column(
        children: [
          const _EditChildProfileHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // كارت الصورة بنباصيله الـ Model ودالة فتح الكاميرا
                    _ChildPhotoCard(
                      childData: widget.childData,
                      onCameraTap: () => _showImageSourceDialog(context),
                    ),
                    const SizedBox(height: 22),

                    const Text('Personal information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                    const SizedBox(height: 16),

                    // كارت البيانات
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 8))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ProfileInputField(
                            iconAsset: ImageAssets.icName2,
                            label: 'Full Name',
                            controller: nameController,
                            validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () => _selectDate(context), // بيفتح النتيجة
                                  child: IgnorePointer( // عشان الكيبورد ميفتحش
                                    child: _SmallProfileInputField(
                                      iconAsset: ImageAssets.icDate,
                                      label: 'Date of birth',
                                      controller: birthDateController,
                                      hint: 'Optional', // لأنه ممكن يتبعت null
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _SmallProfileInputField(
                                  label: 'Age',
                                  controller: ageController,
                                  keyboardType: TextInputType.number,
                                  validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // شيلنا المدرسة، وحطينا الـ Grade
                          _OnlyLabelInputField(
                            label: 'Grade',
                            controller: gradeController,
                            hint: 'e.g. Grade 5-A',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 34),

                    // زرار الحفظ
                    BlocConsumer<EditChildCubit, EditChildState>(
                      listener: (context, state) {
                        if (state is EditChildSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.green));
                          Navigator.pop(context); // نرجع بعد النجاح
                        } else if (state is EditChildError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.red));
                        }
                      },
                      builder: (context, state) {
                        if (state is EditChildLoading) {
                          return const Center(child: CircularProgressIndicator(color: ColorsManager.bluee));
                        }
                        return Center(
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<EditChildCubit>().updateChildProfile(
                                  childId: widget.childData.id,
                                  fullName: nameController.text.trim(),
                                  age: int.tryParse(ageController.text.trim()) ?? 0, // بنحوله لـ int
                                  birthDate: birthDateController.text.trim(),
                                  grade: gradeController.text.trim(),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 260,
                              height: 58,
                              decoration: BoxDecoration(gradient: ColorsManager.blue, borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Text('Save Changes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================================
// Widgets مساعدة مخصصة للشاشة دي
// =======================================================

class _EditChildProfileHeader extends StatelessWidget {
  const _EditChildProfileHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130, width: double.infinity,
      decoration: const BoxDecoration(gradient: ColorsManager.blue, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Row(
            children: [
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28)),
              const SizedBox(width: 6),
              const Expanded(child: Text('Edit Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black))),
              IconButton(onPressed: () => showDialog(context: context, barrierColor: Colors.transparent, builder: (_) => const MenuScreen()), icon: Image.asset(ImageAssets.rivetIconsSettings, width: 26, height: 26, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChildPhotoCard extends StatelessWidget {
  final MyChildModel childData;
  final VoidCallback onCameraTap;

  const _ChildPhotoCard({required this.childData, required this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getData(key: 'token');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 8))]),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 118, height: 118,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 14, offset: const Offset(0, 6))]),
                // 💡 هنا بنسمع للـ Cubit لو اختار صورة جديدة يعرضها، ولو لأ يعرض القديمة
                child: BlocBuilder<EditChildCubit, EditChildState>(
                  builder: (context, state) {
                    final cubit = context.read<EditChildCubit>();

                    if (cubit.selectedImage != null) {
                      return ClipOval(child: Image.file(cubit.selectedImage!, fit: BoxFit.cover));
                    }
                    // 💡 لو الصورة ممسوحة أو أصلا مفيش صورة، نعرض الأيقونة الرمادي
                    else if (cubit.isImageDeleted || childData.imageUrl == null) {
                      return ClipOval(child: Container(color: Colors.grey[300], child: const Icon(Icons.person, size: 50, color: Colors.grey)));
                    }
                    else {
                      return ClipOval(
                        child: Image.network(childData.imageUrl!, fit: BoxFit.cover, headers: token != null ? {'Authorization': 'Bearer $token'} : null,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300], child: const Icon(Icons.person, size: 50, color: Colors.grey)),
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                right: -4, bottom: -4,
                child: InkWell(
                  onTap: onCameraTap, // بيفتح الشيت
                  child: Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 5))]),
                    child: Center(child: Image.asset(ImageAssets.icCamera, width: 40, height: 40, fit: BoxFit.contain)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(childData.fullName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
          const SizedBox(height: 8),
          Text('Student ID: ${childData.studentId}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.greyText)),
        ],
      ),
    );
  }
}

// الـ TextFormFields
class _ProfileInputField extends StatelessWidget {
  final String iconAsset; final String label; final TextEditingController controller; final String? Function(String?)? validator;
  const _ProfileInputField({required this.iconAsset, required this.label, required this.controller, this.validator});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Image.asset(iconAsset, width: 24, height: 24, fit: BoxFit.contain), const SizedBox(width: 8), Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black))]),
        const SizedBox(height: 10),
        TextFormField(controller: controller, validator: validator, decoration: _inputDecoration()),
      ],
    );
  }
}

class _SmallProfileInputField extends StatelessWidget {
  final String? iconAsset; final String label; final TextEditingController controller; final String? Function(String?)? validator; final TextInputType? keyboardType; final String? hint;
  const _SmallProfileInputField({this.iconAsset, required this.label, required this.controller, this.validator, this.keyboardType, this.hint});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          if (iconAsset != null) ...[Image.asset(iconAsset!, width: 22, height: 22, fit: BoxFit.contain), const SizedBox(width: 8)],
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        ]),
        const SizedBox(height: 10),
        TextFormField(controller: controller, validator: validator, keyboardType: keyboardType, decoration: _inputDecoration(hint: hint)),
      ],
    );
  }
}

class _OnlyLabelInputField extends StatelessWidget {
  final String label; final TextEditingController controller; final String? hint;
  const _OnlyLabelInputField({required this.label, required this.controller, this.hint});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        const SizedBox(height: 10),
        TextFormField(controller: controller, decoration: _inputDecoration(hint: hint)),
      ],
    );
  }
}

// تصميم موحد للحقول
InputDecoration _inputDecoration({String? hint}) {
  return InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    filled: true, fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.black, width: 0.9)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: ColorsManager.bluee, width: 1.5)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.red, width: 0.9)),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
  );
}