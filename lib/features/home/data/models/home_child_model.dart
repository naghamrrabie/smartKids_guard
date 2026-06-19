class HomeChildModel {
  final int childId;
  final String fullName;
  final String schoolName;
  final String studentId;
  final String? grade; // ممكن يرجع null
  final String? imageUrl; // ممكن يرجع null
  final String childState;
  final String schoolAdministrationPhoneNumber;
  final String supervisorBusPhoneNumber;
  final String schoolSecurityPhoneNumber;

  HomeChildModel({
    required this.childId,
    required this.fullName,
    required this.schoolName,
    required this.studentId,
    this.grade,
    this.imageUrl,
    required this.childState,
    required this.schoolAdministrationPhoneNumber,
    required this.supervisorBusPhoneNumber,
    required this.schoolSecurityPhoneNumber,
  });

  factory HomeChildModel.fromJson(Map<String, dynamic> json) {
    return HomeChildModel(
      childId: json['childId'] ?? 0,
      fullName: json['fullName'] ?? '',
      schoolName: json['schoolName'] ?? '',
      studentId: json['studentId'] ?? '',
      grade: json['grade'],
      imageUrl: json['imageUrl'],
      childState: json['childState'] ?? 'Offline',
      schoolAdministrationPhoneNumber: json['schoolAdministrationPhoneNumber'] ?? '',
      supervisorBusPhoneNumber: json['supervisorBusPhoneNumber'] ?? '',
      schoolSecurityPhoneNumber: json['schoolSecurityPhoneNumber'] ?? '',
    );
  }
}