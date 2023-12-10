import 'dart:ffi';

import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/services/favorites_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/like_vdo_controller.dart';

class LikeVdoView extends GetView<LikeVdoController> {
  const LikeVdoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Remove shadow
        backgroundColor: Color(0xff551E68),
        centerTitle: true,
        title: Text('การถูกใจ',
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
      body: Get.find<FavoritesService>().favorites.length == 0
          ? Center(
              child: Text(
                "ไม่มีรายการที่บันทึกไว้", // Thai text for "Don't have bookmark"
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Kanit',
                ),
              ),
            )
          : ListView.builder(
              itemCount: Get.find<FavoritesService>().favorites.length,
              itemBuilder: (context, index) {
                VdoDetail video =
                    Get.find<FavoritesService>().favorites[index].vdoDetail;
                return Card(
                  child: Column(
                    children: [
                      Image.network(video.thumbnail), // Display video thumbnail
                      ListTile(
                        title: Text(video.videoTitle), // Display video title
                        subtitle:
                            Text(video.channelName), // Display channel name
                        onTap: () {
                          // TODO: Implement navigation to video detail page
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
