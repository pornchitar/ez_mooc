import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/user_model.dart';

class EnrollMent {
  final String id;
  final Subject subject;
  final User user;
  final bool isCompleted;
  final Report report;

  EnrollMent({
    required this.id,
    required this.subject,
    required this.user,
    required this.isCompleted,
    required this.report,
  });

  factory EnrollMent.fromJson(Map<String, dynamic> json) => EnrollMent(
        id: json["id"],
        subject: Subject.fromJson(json["subject"]),
        user: User.fromJson(json["user"]),
        isCompleted: json["isCompleted"],
        report: Report.fromJson(json["report"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject.toJson(),
        "user": user.toJson(),
        "isCompleted": isCompleted,
        "report": report.toJson(),
      };
}
