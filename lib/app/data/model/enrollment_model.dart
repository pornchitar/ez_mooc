class Enrollment {
  int enrollmentId;
  int userId;
  int subjectId;
  DateTime enrollmentDate;

  Enrollment({
    required this.enrollmentId,
    required this.userId,
    required this.subjectId,
    required this.enrollmentDate,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      enrollmentId: json['enrollment_id'],
      userId: json['user_id'],
      subjectId: json['subject_id'],
      enrollmentDate: DateTime.parse(json['enrollment_date']),
    );
  }
  // to json
  Map<String, dynamic> toJson() {
    return {
      'enrollment_id': enrollmentId,
      'user_id': userId,
      'subject_id': subjectId,
      'enrollment_date': enrollmentDate.toIso8601String(),
    };
  }
}
