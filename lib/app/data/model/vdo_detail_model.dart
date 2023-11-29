class VdoDetail {
  int id;
  String videoId;
  int subjectId;
  String videoTitle;
  String videoUrl;
  String channelName;
  String thumbnail;

  VdoDetail(
      {required this.id,
      required this.videoId,
      required this.subjectId,
      required this.videoUrl,
      required this.channelName,
      required this.thumbnail,
      required this.videoTitle});

  //forpm json
}
