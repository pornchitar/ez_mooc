class Video {
  int video_id;
  String video_title;
  String video_description;
  String video_thumbnail;
  int sub_id;
  String video_url;
  DateTime video_date;

  Video({
    required this.video_id,
    required this.video_title,
    required this.video_description,
    required this.video_thumbnail,
    required this.sub_id,
    required this.video_url,
    required this.video_date,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      video_id: json['video_id'],
      video_title: json['video_title'],
      video_description: json['video_description'],
      video_thumbnail: json['video_thumbnail'],
      sub_id: json['sub_id'],
      video_url: json['video_url'],
      video_date: DateTime.parse(json['video_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_id': video_id,
      'video_title': video_title,
      'video_description': video_description,
      'video_thumbnail': video_thumbnail,
      'sub_id': sub_id,
      'video_url': video_url,
      'video_date': video_date.toIso8601String(),
    };
  }
}
