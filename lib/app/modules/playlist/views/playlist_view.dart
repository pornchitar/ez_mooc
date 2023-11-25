import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/playlist_controller.dart';
import 'package:ez_mooc/services/subject_service.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key}) : super(key: key);

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  late SubjectService subjectService;
  late PlaylistController playlistController;

  @override
  void initState() {
    super.initState();
    subjectService = Get.find<SubjectService>();
    playlistController = Get.find<PlaylistController>();
  }

  Future<List<yt.Video>> fetchAllVideoData(List<String> vdpUrls) async {
    var ytClient = yt.YoutubeExplode();
    List<yt.Video> videos = [];

    try {
      for (var vdourl in vdpUrls) {
        var regExp = RegExp(
            r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');

        var match = regExp.firstMatch(vdourl);
        if (match != null && match.groupCount >= 1) {
          var vdourl = match.group(1);
          var video = await ytClient.videos.get(yt.VideoId(vdourl.toString()));
          videos.add(video);
        }
      }
    } finally {
      ytClient.close();
    }

    return videos;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubjectService>().yourYoutubePlayerController;
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('${subjectService.currentPlaylist.value.name}')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: YoutubePlayer(
              controller: subjectService.yourYoutubePlayerController =
                  YoutubePlayerController(
                initialVideoId: subjectService.getCurrentVdo(),
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              onEnded: (data) {
                print('Video has ended.');
              },
            ),
          ),
          Expanded(
            // Add an Expanded widget
            child: FutureBuilder(
              key: Key(Get.find<SubjectService>()
                  .getCurrentPlaylist()
                  .id
                  .toString()),
              future:
                  fetchAllVideoData(subjectService.currentPlaylist.value.vdos!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    (snapshot.data as List).isEmpty) {
                  return Center(child: Text('No videos available.'));
                } else {
                  List<yt.Video> videos = snapshot.data as List<yt.Video>;

                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      var video = videos[index];
                      var thumbnailUrl = video.thumbnails.highResUrl ?? '';

                      return ListTile(
                        leading: Image.network(thumbnailUrl),
                        title: Text(video.title),
                        subtitle: Text(video.author),
                        onTap: () {
                          Get.find<SubjectService>().setCurrentVdo(
                              subjectService
                                  .getCurrentPlaylist()
                                  .vdos![index]
                                  .toString());
                          Get.find<SubjectService>()
                              .yourYoutubePlayerController
                              .load(subjectService.getCurrentVdo());
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
