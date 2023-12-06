class ProgressEnrollment {
  int progressId;
  int userId;
  int videoId;
  int enrollmentId;
  int progressPercentage;
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
      progressId: json['ProgressID'],
      userId: json['UserID'],
      videoId: json['VideoID'],
      enrollmentId: json['EnrollmentId'],
      progressPercentage: json['ProgressPercentage'],
      lastViewedTimestamp: DateTime.parse(json['lastViewedTimestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProgressID': progressId,
      'UserID': userId,
      'VideoID': videoId,
      'EnrollmentId': enrollmentId,
      'ProgressPercentage': progressPercentage,
      'lastViewedTimestamp': lastViewedTimestamp.toIso8601String(),
    };
  }
}
