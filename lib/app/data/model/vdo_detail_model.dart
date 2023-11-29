class VdoDetail {
  int videoId;
  int subjectId;
  String videoTitle;
  String videoUrl;
  String channelName;
  String thumbnail;

  VdoDetail({
    required this.videoId,
    required this.subjectId,
    required this.videoTitle,
    required this.videoUrl,
    required this.channelName,
    required this.thumbnail,
  });

  //frrom json
  factory VdoDetail.fromJson(Map<String, dynamic> json) {
    return VdoDetail(
      videoId: json['video_id'],
      subjectId: json['subject_id'],
      videoTitle: json['video_title'],
      videoUrl: json['video_url'],
      channelName: json['channelName'],
      thumbnail: json['thumbnail'],
    );
  }

  // to  json
  Map<String, dynamic> toJson() {
    return {
      'video_id': videoId,
      'subject_id': subjectId,
      'video_title': videoTitle,
      'video_url': videoUrl,
      'channelName': channelName,
      'thumbnail': thumbnail,
    };
  }
}
