class MyChildModel {
  final int id;
  final String? studentId;
  final String fullName;
  final int? age;
  final String? birthDate;
  final String? grade;
  final String? imageUrl;
  final String? school;

  MyChildModel({
    required this.id,
    this.studentId,
    required this.fullName,
    this.age,
    this.birthDate,
    this.grade,
    this.imageUrl,
    this.school,
  });

  factory MyChildModel.fromJson(Map<String, dynamic> json) {
    return MyChildModel(
      id: json['id'] ?? 0,
      studentId: json['studentId'],
      fullName: json['fullName'] ?? '',
      age: json['age'],
      birthDate: json['birthDate'],
      grade: json['grade'],
      imageUrl: json['imageUrl'],
      school: json['school'],
    );
  }
}