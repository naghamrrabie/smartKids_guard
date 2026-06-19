class NotificationModel {
  final String title;
  final String details;
  final String type; // Info, Warning, Critical
  final String dateTime;

  NotificationModel({
    required this.title,
    required this.details,
    required this.type,
    required this.dateTime,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      details: json['details'] ?? '',
      type: json['type'] ?? 'Info',
      dateTime: json['dateTime'] ?? '',
    );
  }

  // 💡 دالة صغيرة عشان لو الباك إند بعت التاريخ 0001 نكتب "قريباً" أو "غير محدد"
  // ولما يظبطه، هيتعرض التاريخ الحقيقي أوتوماتيك
  String get displayTime {
    if (dateTime.startsWith('0001')) {
      return 'Just now'; // قيمة مؤقتة لشياكة الـ UI
    }
    // تقدر بعدين تستخدم باكيدج timeago هنا
    return dateTime.split('T').first;
  }
}