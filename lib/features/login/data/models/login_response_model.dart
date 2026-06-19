class LoginResponseModel {
  final String phoneNumber;
  final String token;
  final String refreshToken;
  final String expiration;

  LoginResponseModel({
    required this.phoneNumber,
    required this.token,
    required this.refreshToken,
    required this.expiration,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      phoneNumber: json['phoneNumber'] ?? '',
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      expiration: json['expiration'] ?? '',
    );
  }
}