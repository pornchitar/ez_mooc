import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/vdo_page_controller.dart';

class VdoPageView extends GetView<VdoPageController> {
  const VdoPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => YoutubePlayer(
          controller: controller.youtubePlayerController,
          showVideoProgressIndicator: true,
        ));
  }
}
