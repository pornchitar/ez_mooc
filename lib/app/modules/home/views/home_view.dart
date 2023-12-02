import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/components/VideoCard.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
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
        elevation: 0, // Remove shadow
        backgroundColor: Color.fromRGBO(144, 94, 150, 1),
        leading: Image.asset(
          'images/logo.png', // Replace with your logo asset
          height: 75.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'images/search_icon.png', // Replace with your search icon asset
              height: 50.0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Section
          Container(
            height: 120.0,
            padding: EdgeInsets.all(10.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
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
              itemCount: Get.find<SubjectService>().playlists.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Obx(
                    () => VideoCard(
                      videoUrl: Get.find<SubjectService>()
                          .playlists[index]
                          .playlistLink,
                    ),
                  ),
                  onTap: () {
                    for (var element in Get.find<SubjectService>()
                        .playlists[index]
                        .vdoDetail) {
                      print(element.videoUrl);
                    }

                    Get.find<VdoDetailService>().setVdoPlaylists(
                      Get.find<SubjectService>()
                          .playlists[index]
                          .vdoDetail
                          .toList(),
                    );
                    Get.find<VdoDetailService>().currentSubject.value =
                        Get.find<SubjectService>().playlists[index];

                    Get.find<VdoDetailService>().setCurrentVdo(
                        Get.find<VdoDetailService>()
                            .currentSubject
                            .value
                            .vdoDetail[0]);

                    Get.find<EnrollmentService>().addEnrollment(
                        Get.find<SubjectService>().playlists[index]);

                    Get.find<EnrollmentService>().setCurrentVdoId(
                        Get.find<SubjectService>()
                            .playlists[index]
                            .vdoDetail[0]
                            .id);
                    Get.toNamed('/playlist');
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
        ],
      ),
    ),
  );
}
