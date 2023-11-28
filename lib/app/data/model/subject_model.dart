import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';

class Subject {
  final int sub_id;
  final String sub_name;
  final int category_id;
  final int user_id;
  final String Youtube_playlist_id;
  final List<Video> video;

  Subject(
      {required this.sub_id,
      required this.sub_name,
      required this.category_id,
      required this.user_id,
      required this.Youtube_playlist_id,
      required this.video});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      sub_id: json['sub_id'],
      sub_name: json['sub_name'],
      category_id: json['category_id'],
      user_id: json['user_id'],
      Youtube_playlist_id: json['Youtube_playlist_id'],
      video: json['video'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub_id': sub_id,
      'sub_name': sub_name,
      'category_id': category_id,
      'user_id': user_id,
      'Youtube_playlist_id': Youtube_playlist_id
    };
  }
}
