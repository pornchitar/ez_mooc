import 'package:ez_mooc/app/data/model/category_model.dart';

class VdoDetail {
  int videoId;
  int subjectId;
  String videoTitle;
  String videoURL;
  String thumbnail;
  String channelName;
  String videoCode;
  String createdAt;
  String updatedAt;
  List<Category> category;

  VdoDetail(
      {required this.videoId,
      required this.subjectId,
      required this.videoTitle,
      required this.videoURL,
      required this.thumbnail,
      required this.channelName,
      required this.videoCode,
      required this.createdAt,
      required this.updatedAt,
      required this.category});

  factory VdoDetail.fromJson(Map<String, dynamic> json) {
    return VdoDetail(
      videoId: json['VideoID'] ?? 0,
      subjectId: json['SubjectID'] ?? 0,
      videoTitle: json['VideoTitle'] ?? '',
      videoURL: json['VideoURL'] ?? '',
      thumbnail: json['Thumbnail'] ?? '',
      channelName: json['ChannelName'] ?? '',
      videoCode: json['VideoCode'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      category: (json['category'] as List<dynamic>?)
              ?.map((categoryJson) => Category.fromJson(categoryJson))
              .toList() ??
          [],
    );
  }
  //to json
  Map<String, dynamic> toJson() => {
        "VideoID": videoId,
        "SubjectID": subjectId,
        "VideoTitle": videoTitle,
        "VideoURL": videoURL,
        "Thumbnail": thumbnail,
        "ChannelName": channelName,
        "VideoCode": videoCode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}
