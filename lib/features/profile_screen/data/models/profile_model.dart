class ProfileResponseModel {
  final String fullName;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final String address;
  final String relation;
  final bool isNotificationsEnabled;
  final bool isReportsEnabled;

  ProfileResponseModel({
    required this.fullName,
    required this.imageUrl,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.relation,
    required this.isNotificationsEnabled,
    required this.isReportsEnabled,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      fullName: json['fullName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      relation: json['relation'] ?? '',
      isNotificationsEnabled: json['isNotificationsEnabled'] ?? false,
      isReportsEnabled: json['isReportsEnabled'] ?? false,
    );
  }

  ProfileResponseModel copyWith({
    String? fullName,
    String? imageUrl,
    String? email,
    String? phoneNumber,
    String? address,
    String? relation,
    bool? isNotificationsEnabled,
    bool? isReportsEnabled,
  }) {
    return ProfileResponseModel(
      fullName: fullName ?? this.fullName,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      relation: relation ?? this.relation,
      isNotificationsEnabled: isNotificationsEnabled ?? this.isNotificationsEnabled,
      isReportsEnabled: isReportsEnabled ?? this.isReportsEnabled,
    );
  }

  // عشان نبعت الداتا للباك إند بسهولة
  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "address": address,
      "relation": relation,
    };
  }

}