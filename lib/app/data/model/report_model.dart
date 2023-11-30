class ProgressEnrollment {
  int progressId;
  int userId;
  int videoId;
  int enrollmentId;
  double progressPercentage;
  DateTime lastViewedTimestamp;

  ProgressEnrollment({
    required this.progressId,
    required this.userId,
    required this.videoId,
    required this.enrollmentId,
    required this.progressPercentage,
    required this.lastViewedTimestamp,
  });

  factory ProgressEnrollment.fromJson(Map<String, dynamic> json) {
    return ProgressEnrollment(
      progressId: json['progress_id'],
      userId: json['user_id'],
      videoId: json['video_id'],
      enrollmentId: json['enrollment_id'],
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
      'enrollment_id': enrollmentId,
      'progress_percentage': progressPercentage,
      'last_viewed_timestamp': lastViewedTimestamp.toIso8601String(),
    };
  }
}
