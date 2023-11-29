import 'package:ez_mooc/app/data/model/enrollment_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

class EnrollmentService extends GetxService {
  RxList<Enrollment> enrollments = <Enrollment>[].obs;
  RxInt lastIdReport = 0.obs;
  RxInt indexVdo = 1.obs;
  Rx<String> currentVDO = "".obs;
  RxInt currentVdoId = 1.obs;

  var selectedItem = 2.obs;

  //get enrollments
  List<Enrollment> get getEnrollments => enrollments.value;

  //set enrollments
  void setEnrollments(List<Enrollment> enrollments) {
    this.enrollments.value = enrollments;
  }

  void changeSelectedItem(int index) {
    selectedItem.value = index;
  }

  String getCurrentVdo() {
    return currentVDO.value;
  }

  void setCurrentVdo(String vdoUrl) {
    print("setCurrentVdo ${vdoUrl}");
    final videoId = extractYouTubeVideoId(vdoUrl);

    if (videoId.isNotEmpty) {
      currentVDO.value = videoId;
    } else {
      print('Invalid YouTube URL');
    }
  }

  void addEnrollment(Subject playlist) {
    bool isEnrolled = enrollments
        .any((enrollment) => enrollment.subjectId == playlist.subjectId);

    if (!isEnrolled) {
      enrollments.add(Enrollment(
          enrollmentId: lastIdReport.value,
          userId: Get.find<UserService>().getCurrentUser().user_id,
          subjectId: playlist.subjectId,
          enrollmentDate: DateTime.now(),
          progress: []));
      currentVdoId.value = lastIdReport.value;
      lastIdReport.value++;
      print('Enrollment added successfully.');
    } else {
      currentVdoId.value = enrollments.indexWhere(
          (enrollment) => enrollment.subjectId == playlist.subjectId);
      print('Subject is already enrolled.');
    }

    print(enrollments.length);
  }

  void removeEnrollment(Subject playlist) {
    enrollments.remove(playlist);
  }

  String extractYouTubeVideoId(String videoUrl) {
    var regExp = RegExp(
        r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');

    var match = regExp.firstMatch(videoUrl);
    if (match != null && match.groupCount >= 1) {
      var videoId = match.group(1);
      print(videoId);
      return videoId!;
    } else {
      // Invalid YouTube URL
      throw Exception('Invalid YouTube URL');
    }
  }
}
