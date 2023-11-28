import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoCard extends StatelessWidget {
  final String videoUrl;

  VideoCard({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VideoDetails>(
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
          VideoDetails videoDetails = snapshot.data!;

          return _buildVideoCard(
              videoDetails, snapshot.data!.title, snapshot.data!.channelName);
        } else {
          return Text('Unknown error occurred');
        }
      },
    );
  }

  Widget _buildVideoCard(
    VideoDetails videoDetails,
    String namePlaylist,
    String authorPlaylist,
  ) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              videoDetails.thumpNail,
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

Future<VideoDetails> extractPlaylistInfo(String playlistUrl) async {
  var ytClient = YoutubeExplode();

  try {
    var playlistId = PlaylistId(playlistUrl);
    var playlist = await ytClient.playlists.get(playlistId);

    var firstVideo = await ytClient.playlists.getVideos(playlistId).first;
    print('First video: ${firstVideo.url}');
    var videoDetails = VideoDetails(
        title: playlist.title,
        channelName: playlist.author,
        views: "",
        thumpNail: firstVideo.thumbnails.highResUrl);
    return videoDetails;
  } catch (e) {
    print('Error: $e');
    return VideoDetails(
        title: "Error",
        channelName: "Error",
        views: "Error",
        thumpNail: "Error");
  } finally {
    ytClient.close();
  }
}
