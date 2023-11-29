class Progress {
  int progressId;
  int userId;
  int videoId;
  int progressPercentage;
  DateTime lastViewedTimestamp;

  Progress({
    required this.progressId,
    required this.userId,
    required this.videoId,
    required this.progressPercentage,
    required this.lastViewedTimestamp,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      progressId: json['progress_id'],
      userId: json['user_id'],
      videoId: json['video_id'],
      progressPercentage: json['progress_percentage'],
      lastViewedTimestamp: DateTime.parse(json['last_viewed_timestamp']),
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'progress_id': progressId,
      'user_id': userId,
      'video_id': videoId,
      'progress_percentage': progressPercentage,
      'last_viewed_timestamp': lastViewedTimestamp.toIso8601String(),
    };
  }
}
