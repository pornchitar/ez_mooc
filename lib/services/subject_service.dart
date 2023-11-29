import 'dart:ffi';

import 'package:ez_mooc/app/data/model/enrollment_model.dart';
import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

class SubjectService extends GetxService {
  Rx<Subject> currentPlaylist =
      Subject(subjectId: 1, subjectName: "", description: "", playlistLink: "")
          .obs;
  RxList<Enrollment> enrollments = <Enrollment>[].obs;
  Rx<String> currentVDO = "".obs;
  RxInt currentVdoId = 1.obs;

  RxInt lastIdReport = 0.obs;
  RxInt indexVdo = 1.obs;
  var selectedItem = 2.obs;

  void changeSelectedItem(int index) {
    selectedItem.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  void setCurrentPlaylist(Subject playlist) {
    currentPlaylist.value = playlist;
  }

  void setEnrollments(List<Enrollment> enrollments) {
    this.enrollments.value = enrollments;
  }

  Subject getCurrentPlaylist() {
    return currentPlaylist.value;
  }

  void addEnrollment(Subject playlist) {
    currentVdoId.value = 1;
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
