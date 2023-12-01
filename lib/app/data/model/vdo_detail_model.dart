class VdoDetail {
  int id;
  String videoId;
  String videoTitle;
  String videoUrl;
  String channelName;
  String thumbnail;

  VdoDetail({
    required this.id,
    required this.videoId,
    required this.videoTitle,
    required this.videoUrl,
    required this.channelName,
    required this.thumbnail,
  });

  factory VdoDetail.fromJson(Map<String, dynamic> json) {
    return VdoDetail(
      id: json['id'],
      videoId: json['videoId'],
      videoTitle: json['videoTitle'],
      videoUrl: json['videoUrl'],
      channelName: json['channelName'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'videoId': videoId,
        'videoTitle': videoTitle,
        'videoUrl': videoUrl,
        'channelName': channelName,
        'thumbnail': thumbnail,
      };
}
