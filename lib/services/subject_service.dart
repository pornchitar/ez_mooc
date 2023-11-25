import 'package:ez_mooc/app/data/model/enrollment_model.dart';
import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SubjectService extends GetxService {
  Rx<Subject> currentPlaylist = Subject().obs;
  RxList<EnrollMent> enrollments = <EnrollMent>[].obs;
  Rx<String> currentVDO = "".obs;
  late YoutubePlayerController yourYoutubePlayerController;

  @override
  void onInit() {
    super.onInit();

    yourYoutubePlayerController = YoutubePlayerController(
      initialVideoId: currentVDO.value,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void onClose() {}

  void setCurrentPlaylist(Subject playlist) {
    currentPlaylist.value = playlist;
  }

  Subject getCurrentPlaylist() {
    return currentPlaylist.value;
  }

  // Add enrollment
  void addEnrollment(Subject playlist) {
    if (!enrollments.value.contains(playlist)) {
      enrollments.add(EnrollMent(
          id: "1",
          subject: playlist,
          user: Get.find<UserService>().getCurrentUser(),
          isCompleted: false,
          report: Report(id: "1", values: [])));
    }
    print(enrollments.length);
  }

  // Remove enrollment
  void removeEnrollment(Subject playlist) {
    enrollments.remove(playlist);
  }

  //get the currentVdo
  String getCurrentVdo() {
    return currentVDO.value;
  }

  void setCurrentVdo(String vdoUrl) {
    print("setCurrentVdo ${vdoUrl}");
    final videoId = extractYouTubeVideoId(vdoUrl);

    if (videoId.isNotEmpty) {
      currentVDO.value = videoId;
      yourYoutubePlayerController.load(videoId);
      yourYoutubePlayerController.play();
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
