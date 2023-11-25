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
        backgroundColor: Colors.white,
        title: Image.asset(
          'images/youtube.jpg', // Replace with the path to your YouTube logo image
          height: 50.0,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller
                  .playlists.length, // Replace with the actual number of videos
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.grey[300],
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0.0, // Set font size to zero for selected items
        unselectedFontSize: 0.0, // Set font size to zero for unselected items
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                size: 45.0), // Adjust the size of the home icon
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: '',
          ),
        ],
      ),
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
