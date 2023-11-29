class Subject {
  int subjectId;
  String subjectName;
  String description;
  String playlistLink;

  Subject({
    required this.subjectId,
    required this.subjectName,
    required this.description,
    required this.playlistLink,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subject_id'],
      subjectName: json['subject_name'],
      description: json['description'],
      playlistLink: json['playlist_link'],
    );
  }

  // to Json,
  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_name': subjectName,
      'description': description,
      'playlist_link': playlistLink,
    };
  }
}
