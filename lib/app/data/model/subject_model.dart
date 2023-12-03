import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';

class Subject {
  int subjectId;
  int categoryId;
  String subjectName;
  String description;
  String playlistLink;
  String createdAt;
  String updatedAt;
  Category category;
  List<VdoDetail> videos;

  Subject({
    required this.subjectId,
    required this.categoryId,
    required this.subjectName,
    required this.description,
    required this.playlistLink,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.videos,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['SubjectID'],
      categoryId: json['CategoryID'],
      subjectName: json['SubjectName'],
      description: json['Description'],
      playlistLink: json['PlaylistLink'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      category: Category.fromJson(json['categories']),
      videos: List<VdoDetail>.from(
          json['videos'].map((x) => VdoDetail.fromJson(x))),
    );
  }
  //to json
  Map<String, dynamic> toJson() => {
        "SubjectID": subjectId,
        "CategoryID": categoryId,
        "SubjectName": subjectName,
        "Description": description,
        "PlaylistLink": playlistLink,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "categories": category.toJson(),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}
