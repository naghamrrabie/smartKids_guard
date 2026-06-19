import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import 'package:smartkids_gurad/core/resources/assets_manager.dart';
import 'package:smartkids_gurad/core/routes_manager.dart';
import 'package:smartkids_gurad/core/widgets/bottom_action_text.dart';
import 'package:smartkids_gurad/core/widgets/info_note_box.dart';
import '../../core/widgets/custom_dropdown_field.dart';

// استدعاء ملفات الـ Cubit والزرار اللي ضفناها
import 'package:smartkids_gurad/features/student%20registration/cubit/create_child_cubit.dart';
import 'package:smartkids_gurad/features/student%20registration/cubit/create_child_state.dart';
import 'package:smartkids_gurad/features/student%20registration/data/model/child_models.dart';
import 'package:smartkids_gurad/core/widgets/custom_primary_button.dart'; // تأكد من المسار

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  // 1. Controllers لكل الحقول
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController deviceSecurityKeyController = TextEditingController();

  // 2. متغيرات المدرسة المختارة
  SchoolModel? selectedSchool;

  @override
  void initState() {
    super.initState();
    // بنطلب من الـ Cubit يجيب المدارس أول ما الشاشة تفتح
    context.read<CreateChildCubit>().fetchSchools();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    deviceSecurityKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsManager.lightBlue, Colors.white],
          ),
        ),
        child: SafeArea(
          // 3. بنلف الـ Layout بـ BlocConsumer عشان نتفاعل مع الـ States
          child: BlocConsumer<CreateChildCubit, CreateChildState>(
            listener: (context, state) {
              // لو الإنشاء نجح، نروح للرئيسية ونشيل الشاشات اللي قبلها
              if (state is CreateChildSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Student Registered Successfully!'), backgroundColor: Colors.green),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesManager.homeScreen,
                      (route) => false,
                );
              }
              // لو في إيرور نظهره في SnackBar
              else if (state is CreateChildError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                );
              }
              else if (state is GetSchoolsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                );
              }
            },
            builder: (context, state) {
              // بنجيب لستة المدارس من الـ Cubit وبنحولها لـ List<String> عشان الـ Dropdown
              final cubit = context.read<CreateChildCubit>();
              final List<String> schoolNames = cubit.schoolsList.map((e) => e.name).toList();

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.03,
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.88,
                                    height: MediaQuery.of(context).size.height * 0.83,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: SizedBox(
                                        width: 307,
                                        height: 665,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.08),
                                                blurRadius: 30,
                                                offset: const Offset(0, 14),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 8),
                                              const Center(
                                                child: Text(
                                                  "Student Registration",
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Center(
                                                child: Text(
                                                  "Register your child's information\n"
                                                      "to start monitoring",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ColorsManager.bluee),
                                                ),
                                              ),
                                              const SizedBox(height: 14),

                                              // First name
                                              const Text("First name", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black)),
                                              const SizedBox(height: 6),
                                              Center(
                                                child: SizedBox(
                                                  width: 252, height: 42,
                                                  child: TextField(
                                                    controller: firstNameController, // ربطنا الكنترولر
                                                    decoration: _fieldDecoration(hint: "Enter First name", prefixAsset: ImageAssets.icName, prefixSize: 20, suffix: null),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),

                                              // Last name
                                              const Text("Last name", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black)),
                                              const SizedBox(height: 6),
                                              Center(
                                                child: SizedBox(
                                                  width: 252, height: 42,
                                                  child: TextField(
                                                    controller: lastNameController, // ربطنا الكنترولر
                                                    decoration: _fieldDecoration(hint: "Enter Last name", prefixAsset: ImageAssets.icName, prefixSize: 20, suffix: null),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),

                                              // Age
                                              const Text("Age", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black)),
                                              const SizedBox(height: 6),
                                              Center(
                                                child: SizedBox(
                                                  width: 252, height: 42,
                                                  child: TextField(
                                                    controller: ageController, // ربطنا الكنترولر
                                                    keyboardType: TextInputType.number,
                                                    decoration: _fieldDecoration(hint: "Enter Age", prefixAsset: ImageAssets.icAge, prefixSize: 18, suffix: null),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),

                                              // School Name
                                              CustomDropdownField(
                                                label: "School Name",
                                                hint: state is GetSchoolsLoading ? "Loading schools..." : "Select School",
                                                value: selectedSchool?.name,
                                                items: schoolNames, // المدارس اللي جاية من الـ API
                                                onChanged: (value) {
                                                  setState(() {
                                                    // بنبحث عن المدرسة اللي اسمها اتطابق مع الاختيار عشان نحتفظ بالـ Object كامل (وبالتالي الـ id)
                                                    selectedSchool = cubit.schoolsList.firstWhere((element) => element.name == value);
                                                  });
                                                },
                                              ),
                                              const SizedBox(height: 10),

                                              // Device Security Key
                                              const Text("Device Security Key", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black)),
                                              const SizedBox(height: 6),
                                              Center(
                                                child: SizedBox(
                                                  width: 252, height: 42,
                                                  child: TextField(
                                                    controller: deviceSecurityKeyController,
                                                    decoration: _fieldDecoration(hint: "************", prefixAsset: ImageAssets.icPassword, prefixSize: 20, suffix: null),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),

                                              const InfoNoteBox(
                                                text: "This information will be linked to your\n"
                                                    "child's RFID tag for tracking and safety\n"
                                                    "monitoring.",
                                              ),
                                              const SizedBox(height: 24),

                                              // 4. الزرار الجديد وربطه بالـ Cubit
                                              Center(
                                                child: state is CreateChildLoading
                                                    ? const CircularProgressIndicator(color: ColorsManager.bluee)
                                                    : CustomPrimaryButton(
                                                  text: "Register Student",
                                                  onPressed: () {
                                                    // التأكد من إن مفيش حاجة فاضية قبل ما نبعت للـ API
                                                    if (firstNameController.text.isEmpty ||
                                                        lastNameController.text.isEmpty ||
                                                        ageController.text.isEmpty ||
                                                        selectedSchool == null ||
                                                        deviceSecurityKeyController.text.isEmpty) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(content: Text('Please fill all fields and select a school')),
                                                      );
                                                      return;
                                                    }

                                                    // مناداة الـ Function وإرسال الداتا
                                                    cubit.createNewChild(
                                                      firstName: firstNameController.text,
                                                      lastName: lastNameController.text,
                                                      age: int.tryParse(ageController.text) ?? 0,
                                                      schoolId: selectedSchool!.id, // بناخد الـ ID بتاع المدرسة المختارة
                                                      securityKey: deviceSecurityKeyController.text,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: BottomActionText(
                                normalText: "Already have an child? ",
                                actionText: "Student Device",
                                onTap: () {
                                  Navigator.pushNamed(context, RoutesManager.studentDevice);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // ديكور الحقول العادية (كما هو بدون تغيير)
  static InputDecoration _fieldDecoration({
    required String hint,
    required String prefixAsset,
    required double prefixSize,
    required Widget? suffix,
  }) {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: const TextStyle(color: ColorsManager.greyText, fontSize: 12),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 10, right: 8),
        child: Image.asset(
          prefixAsset,
          width: prefixSize,
          height: prefixSize,
          fit: BoxFit.contain,
          color: ColorsManager.greyText,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 42),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorsManager.greyBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorsManager.bluee, width: 1),
      ),
    );
  }
}