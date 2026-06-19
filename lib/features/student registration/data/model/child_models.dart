/// 1. موديل قائمة المدارس (للـ Dropdown)
class SchoolModel {
  final int id;
  final String name;

  SchoolModel({required this.id, required this.name});

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

/// 2. موديل استجابة إضافة طفل (مع مراعاة الحقول اللي بترجع Null)
class ChildResponseModel {
  final int id;
  final String? studentId;
  final String? fullName;
  final int? age;
  final String? birthDate;
  final String? grade;
  final String? imageUrl;
  final String? school;

  ChildResponseModel({
    required this.id,
    this.studentId,
    this.fullName,
    this.age,
    this.birthDate,
    this.grade,
    this.imageUrl,
    this.school,
  });

  factory ChildResponseModel.fromJson(Map<String, dynamic> json) {
    return ChildResponseModel(
      id: json['id'] ?? 0,
      studentId: json['studentId'], // يقبل null عادي
      fullName: json['fullName'],
      age: json['age'],
      birthDate: json['birthDate'],
      grade: json['grade'],
      imageUrl: json['imageUrl'],
      school: json['school'],
    );
  }
}