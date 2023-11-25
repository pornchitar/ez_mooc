import 'package:ez_mooc/services/subject_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EnrollmentView extends GetView {
  const EnrollmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> buttonClickedTimes = ValueNotifier(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EnrollmentView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => ListView.builder(
            itemCount: Get.find<SubjectService>().enrollments.length,
            itemBuilder: (context, index) {
              var enrollment = Get.find<SubjectService>().enrollments[index];
              var subject = enrollment.subject;

              return Column(
                children: [
                  ExpansionTile(
                    title: ListTile(
                      title: Text(subject.name.toString()),
                      leading: FutureBuilder<String>(
                        future: getThumbnailUrl(subject.url.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error);
                          } else if (!snapshot.hasData) {
                            return Icon(Icons.image);
                          } else {
                            return Image.network(snapshot.data!);
                          }
                        },
                      ),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: enrollment.report.values.length,
                        itemBuilder: (context, index) {
                          var vdo = enrollment.report.values.elementAt(index);
                          var percentage =
                              enrollment.report.values.elementAt(index);
                          return ListTile(
                            title: Text(enrollment.subject.name.toString()),
                            subtitle:
                                Text(enrollment.subject.author.toString()),
                            leading: FutureBuilder<String>(
                              future: getThumbnailUrl(subject.url.toString()),
                              builder: (context, snapshot) {
                                return SimpleCircularProgressBar(
                                  progressColors: [
                                    Colors.red,
                                    Colors.lightGreen
                                  ],
                                  progressStrokeWidth: 5,
                                  backStrokeWidth: 5,
                                  size: 20,
                                  mergeMode: true,
                                  animationDuration: 3,
                                  valueNotifier: valueNotifier,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FAProgressBar(
                        maxValue: 100,
                        borderRadius: BorderRadius.circular(40),
                        currentValue: enrollment.report.values
                                .reduce((value, element) => value + element) /
                            enrollment.report.values.length,
                        displayText: '%',
                        progressGradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.75),
                            Colors.green.withOpacity(0.75),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<String> getThumbnailUrl(String videoUrl) async {
    var ytClient = yt.YoutubeExplode();
    try {
      var regExp = RegExp(
          r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');

      var match = regExp.firstMatch(videoUrl);
      if (match != null && match.groupCount >= 1) {
        var videoId = match.group(1);
        var video = await ytClient.videos.get(yt.VideoId(videoId.toString()));
        ytClient.close();
        return video.thumbnails.highResUrl ?? '';
      } else {
        // Invalid YouTube URL
        throw Exception('Invalid YouTube URL');
      }
    } finally {
      ytClient.close();
    }
  }
}
