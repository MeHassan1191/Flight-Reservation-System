
// user.dart
class User {
  String userId;
  String userName;
  String password;
  String dateOfBirth;
  String gender;
  String image;
  String flightId;

  User({
    required this.userId,
    required this.userName,
    required this.password,
    required this.dateOfBirth,
    required this.gender,
    required this.image,
    required this.flightId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      password: json['password'],
      dateOfBirth: json['DateOfBirth'],
      gender: json['gender'],
      image: json['image'],
      flightId: json['flightId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'password': password,
      'DateOfBirth': dateOfBirth,
      'gender': gender,
      'image': image,
      'flightId': flightId,
    };
  }
}
