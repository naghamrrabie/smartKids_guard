class SafeZoneModel {
  final int id;
  final String name;
  final double centerLatitude;
  final double centerLongitude;
  final double radius;
  final String type; // Home, School, Custom
  final int childId;

  SafeZoneModel({
    required this.id,
    required this.name,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.radius,
    required this.type,
    required this.childId,
  });

  factory SafeZoneModel.fromJson(Map<String, dynamic> json) {
    return SafeZoneModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      centerLatitude: json['centerLatitude']?.toDouble() ?? 0.0,
      centerLongitude: json['centerLongitude']?.toDouble() ?? 0.0,
      radius: json['radius']?.toDouble() ?? 200.0,
      type: json['type'] ?? 'Custom',
      childId: json['childId'] ?? 0,
    );
  }
}