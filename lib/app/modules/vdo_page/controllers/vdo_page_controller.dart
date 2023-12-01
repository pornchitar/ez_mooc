import 'dart:async';

import 'package:ez_mooc/app/data/model/enrollment_model.dart';
import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../services/enrollment_service.dart';

class VdoPageController extends GetxController {
  late YoutubePlayerController youtubePlayerController;
  RxDouble percentageWatched = 0.0.obs;
  Timer? saveTimer;
  var isPlayerReady = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeYoutubePlayer();
  }

  void initializeYoutubePlayer() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: Get.find<VdoDetailService>().getCurrentVdo().videoId,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    )..addListener(listener);
  }

  void listener() {
    var playerState = youtubePlayerController.value.playerState;
    if (playerState == PlayerState.ended) {
      print("Video ended");
      handleVideoEnd();
    } else if (playerState == PlayerState.playing) {
      managePeriodicUpdate();
    } else if (playerState == PlayerState.paused) {
      savePercentageWatched(percentageWatched.value);
    }

    // Update observable variable for player readiness
    if (isPlayerReady.value != youtubePlayerController.value.isReady) {
      isPlayerReady.value = youtubePlayerController.value.isReady;
    }
  }

  void onClose() {
    youtubePlayerController.removeListener(listener);
    youtubePlayerController.dispose();
    super.onClose();
  }

  void loadVideo(String videoId) {
    try {
      // Instead of creating a new controller, update the existing one
      youtubePlayerController.load(videoId);
      youtubePlayerController
          .play(); // You may need to add this line if it's not playing automatically
    } catch (e) {
      throw Exception("Error loading video: $e");
    }
  }

  void handleVideoEnd() {
    int currentIndex = getIndexOfCurrentVideo();
    int totalVideos =
        Get.find<VdoDetailService>().currentSubject.value.vdoDetail.length;
    savePercentageWatched(100); // Save 100% when the video ends

    print(
        "Video ended. Current index: $currentIndex, Total videos: $totalVideos");

    if (currentIndex < totalVideos - 1) {
      playNextVideo(currentIndex + 1);
    } else {
      print("All videos ended");
      // Optionally, you may want to do something when all videos are finished.
    }
  }

  void managePeriodicUpdate() {
    saveTimer?.cancel(); // Cancel previous timer
    saveTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      double percentage = calculatePercentageWatched(youtubePlayerController);
      savePercentageWatched(percentage);
    });
  }

  void playNextVideo(int index) {
    Get.find<VdoDetailService>().setCurrentVdo(
        Get.find<VdoDetailService>().currentSubject.value.vdoDetail[index]);
    Get.find<EnrollmentService>().currentVdoId.value =
        Get.find<VdoDetailService>().currentSubject.value.vdoDetail[index].id;
    loadVideo(Get.find<VdoDetailService>()
        .currentSubject
        .value
        .vdoDetail[index]
        .videoId);
  }

  void disposeController() {
    saveTimer?.cancel();
    youtubePlayerController.removeListener(initializeYoutubePlayer);
    youtubePlayerController.dispose();
    super.dispose();
  }

  void updatePercentageWatched() {
    if (youtubePlayerController.value.playerState != PlayerState.buffering) {
      double percentage = calculatePercentageWatched(youtubePlayerController);
      savePercentageWatched(percentage);
    }
  }

  int getIndexOfCurrentVideo() {
    String currentVideoId =
        Get.find<VdoDetailService>().getCurrentVdo().videoId;
    List<VdoDetail> playlist =
        Get.find<VdoDetailService>().currentSubject.value.vdoDetail;

    return playlist.indexWhere((video) => video.videoId == currentVideoId);
  }

  double calculatePercentageWatched(YoutubePlayerController controller) {
    return controller.value.position.inSeconds /
        controller.value.metaData.duration.inSeconds *
        100;
  }

  void savePercentageWatched(double percentage) {
    EnrollmentService enrollmentService = Get.find<EnrollmentService>();
    VdoDetailService vdoDetailService = Get.find<VdoDetailService>();

    int currentVideoId = enrollmentService.getCurrentVdoId;
    Subject currentSub = vdoDetailService.currentSubject.value;

    Enrollment currentEnrollment = enrollmentService.enrollments.firstWhere(
      (enrollment) => enrollment.subjectId == currentSub.subjectId,
      orElse: () => throw Exception(
        "-------------------Enrollment not found for video ID: $currentVideoId -------------",
      ),
    );

    for (var element in currentEnrollment.progress) {
      if (element.videoId == currentVideoId) {
        print("found video");
        var videoProgress = currentEnrollment.progress
            .firstWhere((element) => element.videoId == currentVideoId);
        videoProgress.progressPercentage = percentage;
        videoProgress.lastViewedTimestamp = DateTime.now();
        print("====================================");
        print(
          enrollmentService.enrollments
              .firstWhere(
                  (enrollment) => enrollment.subjectId == currentSub.subjectId)
              .progress
              .firstWhere((element) => element.videoId == currentVideoId)
              .toJson(),
        );
        print("====================================");

        break;
      }
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
