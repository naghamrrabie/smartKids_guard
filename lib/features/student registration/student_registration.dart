import 'package:flutter/material.dart';
import 'package:smartkids_gurad/core/resources/colors_manager.dart';
import '../../core/resources/assets_manager.dart';
import '../../core/routes_manager.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  /// قيمة المدرسة المختارة من الـ dropdown
  String? selectedSchool;

  /// الكنترولر الخاص بحقل Device Security Key
  final TextEditingController deviceSecurityKeyController =
  TextEditingController();

  /// ليست المدارس اللي هتظهر في الاختيارات
  final List<String> schoolOptions = [
    "Modern English School Cairo",
    "Cairo American School",
    "Nile International School",
  ];

  @override
  void dispose() {
    deviceSecurityKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // خلفية الشاشة (تدرّج)
      // =========================
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsManager.lightBlue, Colors.white],
          ),
        ),

        child: SafeArea(
          // =========================
          // نفس أسلوب الصفحات اللي قبلها (Responsive)
          // =========================
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // =========================
                        // الكارد الأساسي
                        // =========================
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                              ),

                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.88,
                                height:
                                MediaQuery.of(context).size.height * 0.83,

                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SizedBox(
                                    width: 307,
                                    height: 665,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.black.withOpacity(0.08),
                                            blurRadius: 30,
                                            offset: const Offset(0, 14),
                                          ),
                                        ],
                                      ),

                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),

                                          // =========================
                                          // عنوان الصفحة
                                          // =========================
                                          const Center(
                                            child: Text(
                                              "Student Registration",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          // =========================
                                          // الوصف تحت العنوان
                                          // =========================
                                          Center(
                                            child: Text(
                                              "Register your child's information\n"
                                                  "to start monitoring",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsManager.bluee,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 14),

                                          // =========================
                                          // First name
                                          // =========================
                                          const Text(
                                            "First name",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                decoration: _fieldDecoration(
                                                  hint: "Enter First name",
                                                  prefixAsset: ImageAssets.icName,
                                                  prefixSize: 20,
                                                  suffix: null,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // Last name
                                          // =========================
                                          const Text(
                                            "Last name",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                decoration: _fieldDecoration(
                                                  hint: "Enter Last name",
                                                  prefixAsset: ImageAssets.icName,
                                                  prefixSize: 20,
                                                  suffix: null,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // Age
                                          // =========================
                                          const Text(
                                            "Age",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                keyboardType:
                                                TextInputType.number,
                                                decoration: _fieldDecoration(
                                                  hint: "Enter Age",
                                                  prefixAsset: ImageAssets.icAge,
                                                  prefixSize: 18,
                                                  suffix: null,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // School Name
                                          // Dropdown فعلي
                                          // =========================
                                          const Text(
                                            "School Name",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child:
                                              DropdownButtonFormField<String>(
                                                value: selectedSchool,
                                                icon: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color:
                                                  ColorsManager.greyText,
                                                  size: 22,
                                                ),
                                                decoration: _dropdownDecoration(
                                                  hint: "Select School",
                                                ),
                                                items: schoolOptions
                                                    .map((school) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: school,
                                                    child: Text(
                                                      school,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedSchool = value;
                                                  });
                                                },

                                                /// ده بيخلي القائمة المنسدلة شكلها قريب من اللي في الصورة
                                                dropdownColor: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                menuMaxHeight: 180,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // Device Security Key
                                          // =========================
                                          const Text(
                                            "Device Security Key",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Center(
                                            child: SizedBox(
                                              width: 252,
                                              height: 42,
                                              child: TextField(
                                                controller:
                                                deviceSecurityKeyController,
                                                decoration: _fieldDecoration(
                                                  hint: "************",
                                                  prefixAsset:
                                                  ImageAssets.icPassword,
                                                  prefixSize: 20,
                                                  suffix: null,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // =========================
                                          // Info Box
                                          // =========================
                                          Center(
                                            child: Container(
                                              width: 252,
                                              padding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ColorsManager
                                                    .greyBackground,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: ColorsManager.greyBorder,
                                                  width: 1,
                                                ),
                                              ),
                                              child: const Text(
                                                "💡 This information will be linked to your\n"
                                                    "child's RFID tag for tracking and safety\n"
                                                    "monitoring.",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: ColorsManager.greyText,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.2,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 24),

                                          // =========================
                                          // زر Register Student
                                          // =========================
                                          Center(
                                            child: SizedBox(
                                              width: 238,
                                              height: 44,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  gradient: ColorsManager.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                      context,
                                                      RoutesManager.homeScreen,
                                                          (route) => false,
                                                    );
                                                  },
                                                  style:
                                                  ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    Colors.transparent,
                                                    shadowColor:
                                                    Colors.transparent,
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Reigster Student",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
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

                        // =========================
                        // السطر اللي تحت الكارد
                        // =========================
                        Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an child? ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorsManager.greyText,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.studentDevice,
                                  );
                                },
                                child: const Text(
                                  "Student Device",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorsManager.bluee,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =========================
  // ديكور الحقول العادية
  // =========================
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
      hintStyle: const TextStyle(
        color: ColorsManager.greyText,
        fontSize: 12,
      ),
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
      prefixIconConstraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 42,
      ),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: ColorsManager.greyBorder,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: ColorsManager.bluee,
          width: 1,
        ),
      ),
    );
  }

  // =========================
  // ديكور خاص بالـ Dropdown
  // =========================
  static InputDecoration _dropdownDecoration({
    required String hint,
  }) {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: const TextStyle(
        color: ColorsManager.greyText,
        fontSize: 12,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: ColorsManager.greyBorder,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: ColorsManager.bluee,
          width: 1,
        ),
      ),
    );
  }
}