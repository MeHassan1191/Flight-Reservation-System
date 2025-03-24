class person{
  String? id;
  bool? isAdmin;
  person({required this.id,required this.isAdmin});
  factory person.fromJson(Map<String, dynamic> json) {
    return person(
      id: json['UserId'],   // Change here
      isAdmin: json['IsAdmin'],  // Change here
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserId': id,
      'IsAdmin': isAdmin
    };
  }
}