class User {
  int user_id;
  String user_name;
  String user_password;
  String image;
  DateTime created_at;
  String role;

  User({
    required this.user_id,
    required this.user_name,
    required this.user_password,
    required this.image,
    required this.created_at,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_password: json['user_password'],
      image: json['image'],
      created_at: DateTime.parse(json['created_at']),
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_name': user_name,
      'user_password': user_password,
      'image': image,
      'created_at': created_at.toIso8601String(),
      'role': role,
    };
  }
}
