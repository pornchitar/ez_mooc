import 'dart:ffi';

import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/vdo_page_controller.dart';

class VdoPageView extends GetView<VdoPageController> {
  const VdoPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: controller.youtubePlayerController,
              showVideoProgressIndicator: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              var currentVdo = Get.find<VdoDetailService>().getCurrentVdo();
              return Text(
                currentVdo.videoTitle,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() {
                bool isLiked = controller.isVideoLiked();
                return IconButton(
                  iconSize: 30.0,
                  icon: Icon(
                    isLiked
                        ? Icons.thumb_up
                        : Icons
                            .thumb_up_alt_outlined, // Change icons based on like state
                    color: isLiked
                        ? Colors.blue
                        : Colors.grey, // Change color based on like state
                  ),
                  onPressed: () {
                    // Toggle like state
                    controller.toggleLike();
                    controller.isLiked.value = !controller.isLiked.value;
                  },
                );
              }),
              Obx(() {
                bool isBookmarked = controller.isVideoBookmarked();
                return IconButton(
                  iconSize: 30.0,
                  icon: Icon(
                    isBookmarked
                        ? Icons.bookmark
                        : Icons
                            .bookmark_border, // Change icons based on bookmark state
                    color: isBookmarked
                        ? Colors.red
                        : Colors.grey, // Change color based on bookmark state
                  ),
                  onPressed: () {
                    // Toggle bookmark state
                    controller.toggleBookmark();
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
