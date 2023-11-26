import 'dart:async';

import 'package:ez_mooc/services/subject_service.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VdoPageController extends GetxController {
  late YoutubePlayerController youtubePlayerController;
  RxDouble percentageWatched = 0.0.obs;
  Timer? saveTimer;

  @override
  void onInit() {
    super.onInit();
    initializeYoutubePlayer();
  }

  void initializeYoutubePlayer() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: Get.find<SubjectService>().getCurrentVdo(),
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
    // Save the percentage watched to your data structure
    Get.find<SubjectService>()
        .enrollments[Get.find<SubjectService>().currentVdoId.value]
        .report
        .values[Get.find<SubjectService>().indexVdo.value] = percentage;
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
