import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/components/VideoCard.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color.fromRGBO(144, 94, 150, 1),
        title: Row(
          children: [
            Image.asset(
              'images/logo.png', // Replace with the path to your YouTube logo image
              height: 70.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'EZ MOOC',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'images/find.png', // Replace with the path to your play_circle image
              height: 50.0,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.playlists
                    .length, // Replace with the actual number of videos
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Obx(
                      () => VideoCard(
                        videoUrl: controller.playlists[index].url.toString(),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed('/playlist',
                          arguments: controller.playlists[index]);
                      Get.find<SubjectService>()
                          .setCurrentPlaylist(controller.playlists[index]);
                      Get.find<SubjectService>()
                          .addEnrollment(controller.playlists[index]);
                      Get.find<SubjectService>().setCurrentVdo(
                          controller.playlists[index].vdos![0].toString());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(),
    );
  }
}

Future<VideoDetails> getYouTubeVideoDetails(String videoUrl) async {
  var yt = YoutubeExplode();
  var regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');

  var match = regExp.firstMatch(videoUrl);
  if (match != null && match.groupCount >= 1) {
    var videoId = match.group(1);
    print(videoId);
    var video = await yt.videos.get(videoId);
    var videoDetails = VideoDetails(
      title: video.title,
      channelName: video.author,
      views: video.engagement.viewCount.toString(),
      thumpNail: 'https://i.ytimg.com/vi/$videoId/maxresdefault.jpg',
    );

    yt.close();

    return videoDetails;
  } else {
    // Invalid YouTube URL
    throw Exception('Invalid YouTube URL');
  }
}
