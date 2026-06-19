import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // 💡 ضفنا المكتبة هنا
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/home/widgets/bottom_nav_bar.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:smartkids_gurad/features/profile_screen/edit_profile/cubit/edit_profile_state.dart';
import 'package:smartkids_gurad/features/profile_screen/widgets/menu.dart';

// ⚠️ تأكد من المسارات دي عندك:
import 'package:smartkids_gurad/features/profile_screen/data/models/profile_model.dart';

/// =======================================================
/// شاشة Edit Profile (StatefulWidget عشان الـ Controllers والـ Form)
/// =======================================================
class EditProfileScreen extends StatefulWidget {
  final ProfileResponseModel profileData;

  const EditProfileScreen({super.key, required this.profileData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController relationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profileData.fullName);
    emailController = TextEditingController(text: widget.profileData.email);
    addressController = TextEditingController(text: widget.profileData.address);
    relationController = TextEditingController(text: widget.profileData.relation);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    relationController.dispose();
    super.dispose();
  }

  // 💡 دالة اختيار الصورة
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null && context.mounted) {
      context.read<EditProfileCubit>().setImage(File(pickedFile.path));
    }
  }

  // 💡 الشيت بتاع الاختيارات (كاميرا، استوديو، مسح)
  void _showImageOptionsDialog(BuildContext context) {
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
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Photo', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).pop();
                context.read<EditProfileCubit>().deleteProfileImage();
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
          } else if (i == 3) {
            Navigator.pushNamedAndRemoveUntil(context, RoutesManager.profileScreen, (route) => false);
          }
        },
      ),
      body: Column(
        children: [
          const _EditProfileHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// كارت الصورة المحمية 💡 (باصيناله الدالة هنا)
                    _ProfilePhotoCard(
                      imageUrl: widget.profileData.imageUrl,
                      onCameraTap: () => _showImageOptionsDialog(context),
                    ),
                    const SizedBox(height: 26),

                    const Text(
                      'Personal information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
                    ),
                    const SizedBox(height: 16),

                    /// كارت البيانات الشخصية اللي فيه الـ TextFormFields
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: Column(
                        children: [
                          _ProfileInputField(
                            iconAsset: ImageAssets.icName2,
                            label: 'First name',
                            controller: nameController,
                            validator: (val) => val == null || val.trim().isEmpty ? 'Please enter your name' : null,
                          ),
                          const SizedBox(height: 16),

                          _ProfileInputField(
                            iconAsset: ImageAssets.icEmail2,
                            label: 'Email',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) return 'Please enter your email';
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                                return 'Please enter a valid email format';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          _ProfileInputField(
                            iconAsset: ImageAssets.icHome2,
                            label: 'Home Address',
                            controller: addressController,
                            validator: (val) => val == null || val.trim().isEmpty ? 'Please enter your address' : null,
                          ),
                          const SizedBox(height: 16),

                          _ProfileInputField(
                            iconAsset: ImageAssets.icRelation,
                            label: 'Relation',
                            controller: relationController,
                            validator: (val) => val == null || val.trim().isEmpty ? 'Please enter your relation' : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 34),

                    /// ===========================================
                    /// زرار Save Changes مربوط بالـ Cubit
                    /// ===========================================
                    BlocConsumer<EditProfileCubit, EditProfileState>(
                      listener: (context, state) {
                        if (state is EditProfileSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile Updated Successfully!'), backgroundColor: Colors.green),
                          );
                          Navigator.pop(context);
                        } else if (state is EditProfileError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                          );
                        }
                        // 💡 الـ SnackBar بتاع مسح الصورة
                        else if (state is EditProfileImageDeleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is EditProfileLoading) {
                          return const Center(child: CircularProgressIndicator(color: ColorsManager.bluee));
                        }

                        return Center(
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<EditProfileCubit>().updateProfileData(
                                  widget.profileData,
                                  fullName: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  address: addressController.text.trim(),
                                  relation: relationController.text.trim(),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(20),
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
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                                ),
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

/// =======================================================
/// Header
/// =======================================================
class _EditProfileHeader extends StatelessWidget {
  const _EditProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: ColorsManager.blue,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Row(
            children: [
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28)),
              const SizedBox(width: 6),
              const Expanded(child: Text('Edit Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black))),
              IconButton(
                onPressed: () {
                  showDialog(context: context, barrierColor: Colors.transparent, builder: (_) => const MenuScreen());
                },
                icon: Image.asset(ImageAssets.rivetIconsSettings, width: 26, height: 26, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// كارت صورة البروفايل (بيدعم الصورة من الـ API المحمية بالتوكن)
/// =======================================================
class _ProfilePhotoCard extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onCameraTap; // 💡 الدالة اللي بتفتح الشيت

  const _ProfilePhotoCard({required this.imageUrl, required this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getData(key: 'token');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // 💡 ربط الصورة بالـ Cubit
              BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  final cubit = context.read<EditProfileCubit>();

                  if (cubit.selectedImage != null) {
                    return Container(
                      width: 120, height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 14, offset: const Offset(0, 6))],
                        image: DecorationImage(image: FileImage(cubit.selectedImage!), fit: BoxFit.cover),
                      ),
                    );
                  } else if (cubit.isImageDeleted || imageUrl == null || imageUrl!.isEmpty) {
                    return Container(
                      width: 120, height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300],
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 14, offset: const Offset(0, 6))],
                      ),
                      child: const Icon(Icons.person, size: 60, color: Colors.grey),
                    );
                  } else {
                    return Container(
                      width: 120, height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 14, offset: const Offset(0, 6))],
                        image: DecorationImage(
                          image: NetworkImage(imageUrl!, headers: token != null ? {'Authorization': 'Bearer $token'} : null),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: InkWell(
                  onTap: onCameraTap, // 💡 بتفتح الشيت
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: const Offset(0, 5))],
                    ),
                    child: Center(child: Image.asset(ImageAssets.icCamera, width: 55, height: 55)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text('Profile Photo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
          const SizedBox(height: 8),
          const Text(
            'Click the camera icon to change your photo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.greyText),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
/// Widget مسؤول عن عنصر إدخال واحد (TextFormField)
/// =======================================================
class _ProfileInputField extends StatelessWidget {
  final String iconAsset;
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const _ProfileInputField({
    required this.iconAsset,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(iconAsset, width: 26, height: 26, fit: BoxFit.contain),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.black, width: 0.9)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: ColorsManager.bluee, width: 1.5)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.red, width: 0.9)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
          ),
        ),
      ],
    );
  }
}