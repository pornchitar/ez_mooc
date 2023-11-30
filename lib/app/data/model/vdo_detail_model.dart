class VdoDetail {
  int id;
  String videoId;
  int subjectId;
  String videoTitle;
  String videoUrl;
  String channelName;
  String thumbnail;

  VdoDetail({
    required this.id,
    required this.videoId,
    required this.subjectId,
    required this.videoTitle,
    required this.videoUrl,
    required this.channelName,
    required this.thumbnail,
  });

  factory VdoDetail.fromJson(Map<String, dynamic> json) {
    return VdoDetail(
      id: json['id'],
      videoId: json['videoId'],
      subjectId: json['subjectId'],
      videoTitle: json['videoTitle'],
      videoUrl: json['videoUrl'],
      channelName: json['channelName'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'videoId': videoId,
        'subjectId': subjectId,
        'videoTitle': videoTitle,
        'videoUrl': videoUrl,
        'channelName': channelName,
        'thumbnail': thumbnail,
      };
}
