import 'dart:ffi';

import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoCard extends StatelessWidget {
  final String videoUrl;

  VideoCard({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VdoDetail>(
      future: extractPlaylistInfo(videoUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: CircularProgressIndicator(),
            width: 30,
            height: 30,
          );
        } else if (snapshot.hasError) {
          return Text('Error loading video details');
        } else if (snapshot.hasData) {
          VdoDetail vdoDetail = snapshot.data!;

          return _buildVideoCard(
              vdoDetail, snapshot.data!.videoTitle, snapshot.data!.channelName);
        } else {
          return Text('Unknown error occurred');
        }
      },
    );
  }

  Widget _buildVideoCard(
    VdoDetail vdoDetail,
    String namePlaylist,
    String authorPlaylist,
  ) {
    print(namePlaylist);
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              vdoDetail.thumbnail ?? '',
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.library_music, color: Colors.black),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    namePlaylist,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${authorPlaylist} • ${_formatUploadDate(DateTime.now())}',
            ),
          ),
        ],
      ),
    );
  }

  String _formatUploadDate(DateTime uploadDate) {
    var daysSinceUpload = DateTime.now().difference(uploadDate).inDays;

    if (daysSinceUpload == 0) {
      return 'Today';
    } else if (daysSinceUpload == 1) {
      return 'Yesterday';
    } else {
      return '$daysSinceUpload days ago';
    }
  }
}

Future<VdoDetail> extractPlaylistInfo(String playlistUrl) async {
  var ytClient = YoutubeExplode();

  try {
    var playlistId = PlaylistId(playlistUrl);
    var playlist = await ytClient.playlists.get(playlistId);

    var firstVideo = await ytClient.playlists.getVideos(playlistId).first;
    print('First video: ${firstVideo.url}');

    var vdoDetail = VdoDetail(
      id:1,
      videoId: playlistId.value, // Use the YouTube video ID as a string
      subjectId: 1,
      videoTitle: playlist.title,
      videoUrl: firstVideo.url.toString(),
      channelName: playlist.author,
      thumbnail: firstVideo.thumbnails.highResUrl,
    );

    return vdoDetail;
  } catch (e) {
    print('Error: $e');
    return VdoDetail(
        id: -1,
        videoId: "",
        subjectId: -1,
        videoTitle: "",
        videoUrl: "",
        channelName: "",
        thumbnail: "");
  } finally {
    ytClient.close();
  }
}
