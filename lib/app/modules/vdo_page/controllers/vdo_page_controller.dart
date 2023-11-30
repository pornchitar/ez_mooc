import 'dart:async';

import 'package:ez_mooc/app/data/model/enrollment_model.dart';
import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../services/enrollment_service.dart';

class VdoPageController extends GetxController {
  late YoutubePlayerController youtubePlayerController;
  RxDouble percentageWatched = 0.0.obs;
  Timer? saveTimer;

  @override
  void onInit() {
    super.onInit();
    initializeYoutubePlayer();
  }

  void loadVideo(String videoId) {
    youtubePlayerController.load(videoId);
  }

  void initializeYoutubePlayer() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: Get.find<VdoDetailService>().getCurrentVdo().videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    youtubePlayerController.addListener(() {
      // Handle video state changes
      if (youtubePlayerController.value.playerState == PlayerState.ended) {
        savePercentageWatched(100);
        print('Video ended. Track the history here.');
      } else if (youtubePlayerController.value.playerState ==
          PlayerState.paused) {
        print("--------------------------------");
        double percentage = calculatePercentageWatched(youtubePlayerController);
        savePercentageWatched(percentage);
        print(
            'Video paused. Track the history here. ${percentage.toStringAsPrecision(2)}%');
        print("--------------------------------");
      } else if (youtubePlayerController.value.playerState ==
          PlayerState.playing) {
        saveTimer = Timer.periodic(Duration(minutes: 1), (timer) {
          double percentage =
              calculatePercentageWatched(youtubePlayerController);
          savePercentageWatched(percentage);
          print(
              'Saving percentage every 5 minutes: ${percentage.toStringAsPrecision(2)}%');
        });
      }
    });
  }

  double calculatePercentageWatched(YoutubePlayerController controller) {
    return controller.value.position.inSeconds /
        controller.value.metaData.duration.inSeconds *
        100;
  }

  void savePercentageWatched(double percentage) {
    int currentVideoId = Get.find<EnrollmentService>().getCurrentVdoId;
    Subject currentSub = Get.find<VdoDetailService>().currentSubject.value;
    print(currentSub.toJson());
    print(currentVideoId);
    Enrollment currentEnrollment = Get.find<EnrollmentService>()
        .enrollments
        .firstWhere(
            (enrollment) => enrollment.subjectId == currentSub.subjectId,
            orElse: () => throw Exception(
                "-------------------Enrollment not found for video ID: $currentVideoId -------------"));
    print(currentEnrollment.toJson());
    for (var element in currentEnrollment.progress) {
      print(element.toJson());
      if (element.videoId == currentVideoId) {
        element.progressPercentage = percentage;
        element.lastViewedTimestamp = DateTime.now();

        Get.find<EnrollmentService>()
            .enrollments
            .firstWhere(
                (enrollment) => enrollment.subjectId == currentSub.subjectId)
            .progress[currentVideoId] = element;

        print("====================================");
        print(Get.find<EnrollmentService>()
            .enrollments
            .firstWhere(
                (enrollment) => enrollment.subjectId == currentSub.subjectId)
            .toJson());
        print("====================================");

        break;
      }
    }

    // var progress = currentEnrollment.progress.firstWhere(
    //     (element) => element.videoId == indexVideo,
    //     orElse: () =>
    //         throw Exception("Progress not found for video ID: $indexVideo"));
    // progress.progressPercentage = percentage;
    // currentEnrollment.progress[indexVideo] = progress;
    // enrollments[currentVideoId] = currentEnrollment;
    // Get.find<EnrollmentService>().setEnrollments(enrollments);
  }

  @override
  void onClose() {
    youtubePlayerController.dispose();
    super.onClose();
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
