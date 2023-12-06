import 'package:ez_mooc/app/data/model/enrollment_model.dart';
import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/repositories/enrollment_repository.dart';
import 'package:ez_mooc/app/data/repositories/report_repository.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

class EnrollmentService extends GetxService {
  final enrollmentRepository = EnrollmentRepository();
  final progessEnrollment = ProgessRepository();
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

  //get currentVdoId
  int get getCurrentVdoId => currentVdoId.value;
  //set currentVdoId
  void setCurrentVdoId(int id) {
    currentVdoId.value = id;
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
        progress: List.generate(
          playlist.videos.length,
          (index) => ProgressEnrollment(
            progressId: index,
            userId: Get.find<UserService>().currentUser.value.user_id,
            videoId: playlist.videos[index].videoId,
            enrollmentId: lastIdReport.value,
            progressPercentage: 0,
            lastViewedTimestamp: DateTime.now(),
          ),
        ),
      ));

      currentVdoId.value = lastIdReport.value;
      lastIdReport.value++;
      print('Enrollment added successfully.');
    } else {
      currentVdoId.value = enrollments.indexWhere(
          (enrollment) => enrollment.subjectId == playlist.subjectId);
      print('Subject is already enrolled.');
    }
    print("-------------------");
    for (var element in enrollments) {
      for (var element_ in element.progress) {
        print(element_.progressPercentage);
      }
    }
    print("-------------------");
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

  Future<List<Enrollment>> getEnrolmentsByUserId() async {
    try {
      List<Enrollment> fetchedEnrollments =
          await enrollmentRepository.getEnrolmentsByUserId(
              Get.find<UserService>().getCurrentUser().user_id);

      // enrollments.value = fetchedEnrollments;

      //get progress by id
      List<ProgressEnrollment> fetchedProgress =
          await progessEnrollment.getProgressByUserId(
              Get.find<UserService>().getCurrentUser().user_id);
      print(fetchedProgress.toList().map((e) => e.toJson()).toList());
      //map fetchedEnrollments and fetchedProgress
      for (var element in fetchedEnrollments) {
        element.progress = fetchedProgress
            .where((progress) => progress.enrollmentId == element.enrollmentId)
            .toList();
      }
      enrollments.value = fetchedEnrollments;
      print("Enrollments fetched: ${enrollments.toJson()}");
      return fetchedEnrollments;
    } catch (e) {
      print(e);
      return [];
    }
  }

  //getList progess by user id
  Future<void> getProgressByUserId() async {
    try {
      List<ProgressEnrollment> fetchedProgress =
          await progessEnrollment.getProgressByUserId(
              Get.find<UserService>().getCurrentUser().user_id);
      print("Enrollments fetched: ${enrollments.toJson()}");
    } catch (e) {
      print(e);
    }
  }
}
