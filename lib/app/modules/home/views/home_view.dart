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
              'images/logo.png',
              height: 75.0,
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
              'images/find.png',
              height: 50.0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 120.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10.0),
              children: [
                _buildCategoryCard('images/TV.png', 'ศาสนา'),
                _buildCategoryCard('images/find.png', 'สุขภาพจิต'),
                _buildCategoryCard('images/home.png', 'ศิลปะ'),
                _buildCategoryCard('images/heart.png', 'การลงทุน'),
                _buildCategoryCard('images/TV.png', 'การเมือง'),
                _buildCategoryCard('images/find.png', 'การเรียน'),
                _buildCategoryCard('images/home.png', 'การเรียน'),
                // Add more category cards as needed
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.playlists.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Obx(
                    () => VideoCard(
                      videoUrl: controller.playlists[index].playlistLink,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed('/playlist',
                        arguments: controller.playlists[index]);
                    Get.find<SubjectService>()
                        .setCurrentPlaylist(controller.playlists[index]);
                    Get.find<SubjectService>()
                        .addEnrollment(controller.playlists[index]);
                    Get.find<SubjectService>().setCurrentVdo(controller
                        .playlists[index].playlistLink![0]
                        .toString());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCategoryCard(String imagePath, String category) {
  return Container(
    width: 120.0, // Adjust the width to make the card square
    height: 170.0, // Adjust the height to include space for text below
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Card(
      color: Color.fromRGBO(144, 94, 150, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 50.0,
          ),
          SizedBox(height: 8.0), // Adjust the spacing between image and text
          Text(
            category,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
