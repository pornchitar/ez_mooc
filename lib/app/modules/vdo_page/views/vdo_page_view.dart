import 'dart:ffi';

import 'package:ez_mooc/services/subject_service.dart';
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
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // Ensures the column items are stretched to fill the width of the screen.
        children: [
          Expanded(
              child: YoutubePlayer(
            controller: controller.youtubePlayerController,
            showVideoProgressIndicator: true,
          )),
          Padding(
            padding: const EdgeInsets.all(
                8.0), // Adds some padding around the title for better readability.
            child: Obx(() => Text(
                  Get.find<VdoDetailService>()
                      .getCurrentVdo()
                      .videoTitle, // This should be the variable where the video title is stored.
                  style: TextStyle(
                    fontSize:
                        18.0, // The size of the font can be adjusted according to your design.
                    fontWeight:
                        FontWeight.w600, // Makes the font a little bolder.
                  ),
                  textAlign: TextAlign.center, // Centers the title.
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                iconSize: 30.0,
                icon: Icon(
                  Icons.thumb_up_alt_outlined, // Like icon
                  color: Colors.grey, // Icon color
                ),
                onPressed: () {
                  // Implement like functionality
                },
              ),
              IconButton(
                iconSize: 30.0,
                icon: Icon(
                  Icons.bookmark_border, // Bookmark icon
                  color: Colors.grey, // Icon color
                ),
                onPressed: () {
                  // Implement bookmark functionality
                },
              ),
            ],
          ),
          // ... other widgets if needed
        ],
      ),
    );
  }
}
