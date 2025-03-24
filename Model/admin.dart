// admin.dart
class Admin {
  String adminId;
  String adminPassword;

  Admin({required this.adminId, required this.adminPassword});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      adminId: json['admin_id'],
      adminPassword: json['admin_Password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admin_id': adminId,
      'admin_Password': adminPassword,
    };
  }
}