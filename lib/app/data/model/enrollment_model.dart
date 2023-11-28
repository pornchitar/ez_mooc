class Enrollment {
  int user_id;
  int sub_id;
  double enroll_progress_list; // Change this to a single double
  String status;

  Enrollment({
    required this.user_id,
    required this.sub_id,
    required this.enroll_progress_list,
    required this.status,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      user_id: json['user_id'],
      sub_id: json['sub_id'],
      enroll_progress_list: json['enroll_progress_list'], // Change this line
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'sub_id': sub_id,
      'enroll_progress_list': enroll_progress_list,
      'status': status,
    };
  }
}
