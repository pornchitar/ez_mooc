import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/app/modules/vdo_page/controllers/vdo_page_controller.dart';
import 'package:ez_mooc/app/modules/vdo_page/views/vdo_page_view.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:get/get.dart';

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

  Future<List<yt.Video>> fetchAllVideoData(List<VdoDetail> playlistUrl) async {
    var ytClient = yt.YoutubeExplode();
    List<yt.Video> videos = [];

    try {
      for (var vdourl in playlistUrl) {
        var regExp = RegExp(
            r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');

        var match = regExp.firstMatch(vdourl.videoURL);
        if (match != null && match.groupCount >= 1) {
          var vdourl_ = match.group(1);
          var video = await ytClient.videos.get(yt.VideoId(vdourl_.toString()));
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff551E68),
        title: Obx(() => Text(
            '${subjectService.currentPlaylist.value.subjectName}',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold))),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          VdoPageView(),
          SizedBox(height: 10.0),
          Expanded(
            // Add an Expanded widget
            child: FutureBuilder(
              key: Key(Get.find<EnrollmentService>().getCurrentVdo()),
              future: fetchAllVideoData(Get.find<VdoDetailService>()
                  .currentSubject
                  .value
                  .videos
                  .toList()),
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
                          Get.find<EnrollmentService>().currentVdoId.value =
                              Get.find<VdoDetailService>()
                                  .currentSubject
                                  .value
                                  .videos[index]
                                  .videoId;
                          print(
                              "currentVdoId: ${Get.find<EnrollmentService>().currentVdoId.value}");
                          Get.find<VdoDetailService>().setCurrentVdo(
                              Get.find<VdoDetailService>()
                                  .currentSubject
                                  .value
                                  .videos
                                  .toList()[index]);
                          Get.find<VdoPageController>().loadVideo(
                              Get.find<VdoDetailService>()
                                  .currentSubject
                                  .value
                                  .videos
                                  .toList()[index]
                                  .videoCode);

                          print(
                              "currentVdoId: ${Get.find<EnrollmentService>().currentVdoId.value}");
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
