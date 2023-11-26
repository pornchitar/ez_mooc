import 'package:ez_mooc/services/subject_service.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VdoPageController extends GetxController {
  late YoutubePlayerController youtubePlayerController;
  RxDouble percentageWatched = 0.0.obs;

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
      if (youtubePlayerController.value.playerState == PlayerState.ended) {
        percentageWatched.value = 100;
        Get.find<SubjectService>()
                .enrollments[Get.find<SubjectService>().currentVdoId.value]
                .report
                .values[Get.find<SubjectService>().indexVdo.value] =
            percentageWatched.value;
        for (int i = 0;
            i < Get.find<SubjectService>().enrollments.length;
            i++) {
          print(Get.find<SubjectService>()
              .enrollments[i]
              .report
              .values
              .toString());
        }
        print('Video ended. Track the history here.');
      } else if (youtubePlayerController.value.playerState ==
          PlayerState.paused) {
        print("--------------------------------");
        percentageWatched.value =
            youtubePlayerController.value.position.inSeconds /
                youtubePlayerController.value.metaData.duration.inSeconds *
                100;
        Get.find<SubjectService>()
                .enrollments[Get.find<SubjectService>().currentVdoId.value]
                .report
                .values[Get.find<SubjectService>().indexVdo.value] =
            percentageWatched.value;
        print(
            'Video paused. Track the history here. ${percentageWatched.toStringAsPrecision(2)}%');
        print("--------------------------------");
        for (int i = 0;
            i < Get.find<SubjectService>().enrollments.length;
            i++) {
          print(Get.find<SubjectService>()
              .enrollments[i]
              .report
              .values
              .toString());
        }
      }

      // You can add more conditions based on your requirements
    });
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
