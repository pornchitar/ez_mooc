import 'package:ez_mooc/app/data/model/report_model.dart';

class Enrollment {
  int enrollmentId;
  int userId;
  int subjectId;
  DateTime enrollmentDate;
  List<ProgressEnrollment> progress;

  Enrollment({
    required this.enrollmentId,
    required this.userId,
    required this.subjectId,
    required this.enrollmentDate,
    required this.progress,
  });
  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      enrollmentId: json['EnrollmentID'],
      userId: json['UserID'],
      subjectId: json['SubjectID'],
      enrollmentDate: DateTime.parse(json['EnrollmentDate']),
      progress: (json['progress'] as List<dynamic>?)
              ?.map((x) => ProgressEnrollment.fromJson(x))
              .toList() ??
          [],
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'EnrollmentID': enrollmentId,
      'UserID': userId,
      'SubjectID': subjectId,
      'EnrollmentDate': enrollmentDate.toIso8601String(),
      'progress': progress.map((progress) => progress.toJson()).toList(),
    };
  }
}
