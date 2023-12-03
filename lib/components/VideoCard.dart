import 'dart:ffi';

import 'package:ez_mooc/app/data/model/subject_model.dart';
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
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.white, // Choose a color for the header
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            width: double.infinity,
            child: Text(
              'Header Title', // Replace with your actual header title
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(10.0),
                // topRight: Radius.circular(10.0),
                ),
            child: Image.network(
              vdoDetail.thumbnail ?? '',
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.library_music, color: Colors.black),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        namePlaylist,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${authorPlaylist} • ${_formatUploadDate(DateTime.now())}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
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

    var vdoDetail = VdoDetail(
        videoId: 1,
        subjectId: 1,
        videoTitle: playlist.title,
        videoURL: firstVideo.url.toString(),
        thumbnail: firstVideo.thumbnails.highResUrl,
        channelName: playlist.author,
        videoCode: '',
        createdAt: '',
        updatedAt: '');

    return vdoDetail;
  } catch (e) {
    print('Error: $e');
    return VdoDetail(
        videoId: 1,
        subjectId: 1,
        videoTitle: '',
        videoURL: '',
        thumbnail: '',
        channelName: '',
        videoCode: '',
        createdAt: '',
        updatedAt: '');
  } finally {
    ytClient.close();
  }
}
