import 'dart:convert';

class Subject {
  int? id;
  String? url;
  String? name;
  String? author;
  List<String>? vdos;

  Subject({
    this.id,
    this.url,
    this.name,
    this.author,
    this.vdos,
  });

  factory Subject.fromRawJson(String str) => Subject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        author: json["author"],
        vdos: json["vdos"] == null
            ? []
            : List<String>.from(json["vdos"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "author": author,
        "vdos": vdos == null ? [] : List<dynamic>.from(vdos!.map((x) => x)),
      };
}
