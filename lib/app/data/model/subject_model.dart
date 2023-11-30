import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';

class Subject {
  int subjectId;
  String subjectName;
  String description;
  String playlistLink;
  List<VdoDetail> vdoDetail;

  Subject({
    required this.subjectId,
    required this.subjectName,
    required this.description,
    required this.playlistLink,
    required this.vdoDetail,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subjectId'],
      subjectName: json['subjectName'],
      description: json['description'],
      playlistLink: json['playlistLink'],
      vdoDetail: json['vdoDetail'],
    );
  }

  Map<String, dynamic> toJson() => {
        'subjectId': subjectId,
        'subjectName': subjectName,
        'description': description,
        'playlistLink': playlistLink,
        'vdoDetail': vdoDetail,
      };
}
