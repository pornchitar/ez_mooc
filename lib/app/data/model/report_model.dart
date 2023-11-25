class Report {
  final int id;
  final List<double> values;

  Report({
    required this.id,
    required this.values,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        values: List<double>.from(json["values"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "values": List<dynamic>.from(values.map((x) => x)),
      };
}
