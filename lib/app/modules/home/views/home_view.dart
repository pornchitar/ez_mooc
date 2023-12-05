import 'dart:ffi';
import 'dart:ui';

import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/components/VideoCard.dart';
import 'package:ez_mooc/services/category_service.dart';
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
        backgroundColor: Color(0xff551E68),
        leading: Image.asset(
          'images/logo.png', // Replace with your logo asset
          height: 80.0,
        ),
        title: Text(
          'MOOC',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'Kanit',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'images/find_icon.png', // Replace with your search icon asset
              height: 50.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Container(
                color: Color(0xFFEDE4FF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Section
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Text(
                        'หมวดหมู่',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 180.0,
                      padding: EdgeInsets.all(10.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var element
                              in Get.find<CategoryService>().categories)
                            _buildAllCardDetail(
                                element.categoryImage, element.categoryName)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'แนะนำสำหรับคุณ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Kanit',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Get.find<SubjectService>().playlists.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: VideoCard(
                            videoUrl: Get.find<SubjectService>()
                                .playlists[index]
                                .playlistLink,
                          ),
                          onTap: () {
                            for (var element in Get.find<SubjectService>()
                                .playlists[index]
                                .videos) {
                              print(element.videoURL);
                            }
                            //set current playlist
                            Get.find<SubjectService>().setCurrentPlaylist(
                                Get.find<SubjectService>().playlists[index]);
                            //ser vdoplaylist
                            Get.find<VdoDetailService>().setVdoPlaylists(
                              Get.find<SubjectService>()
                                  .playlists[index]
                                  .videos
                                  .toList(),
                            );
                            //sert current subject
                            Get.find<VdoDetailService>().currentSubject.value =
                                Get.find<SubjectService>().playlists[index];

                            Get.find<VdoDetailService>().setCurrentVdo(
                                Get.find<VdoDetailService>()
                                    .currentSubject
                                    .value
                                    .videos[0]);

                            Get.find<EnrollmentService>().addEnrollment(
                                Get.find<SubjectService>().playlists[index]);

                            Get.find<EnrollmentService>().setCurrentVdoId(
                                Get.find<SubjectService>()
                                    .playlists[index]
                                    .videos[0]
                                    .videoId);
                            Get.toNamed('/playlist');
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildAllCardDetail(String imagePath, String nameCat) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        _buildCategoryCard(imagePath),
        SizedBox(height: 10.0),
        Text(nameCat,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Kanit',
            )),
      ],
    ),
  );
}

Widget _buildCategoryCard(String imagePath) {
  Color backgroundColor = Color(0xFFC3ACD0);

  return Container(
    width: 100.0, // Adjust the width to make the card square
    height: 100.0, // Maintain a square shape
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: backgroundColor.withOpacity(1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: backgroundColor.withOpacity(0.8),
          ),
          child: Center(
            child: Image.network(
              imagePath,
              height: 60.0,
            ),
          ),
        ),
      ),
    ),
  );
}
