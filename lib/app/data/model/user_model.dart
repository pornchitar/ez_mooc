class User {
  final String id;
  final String name;
  final String lastName;

  User({
    required this.id,
    required this.name,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
      };
}
