import 'dart:convert';
import 'dart:ffi';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class HomeController extends GetxController {
  RxList<Subject> playlists = RxList<Subject>.of([
    Subject(
      id: 1,
      url:
          "https://youtube.com/playlist?list=PLth1DquOKn1Kqq_JJxL2laCnHtJ4JU1j7&si=Fm9ttxGCq7erJwtJ",
      name: "พระธรรมเทศนา หลวงพ่อปราโมทย์ ปาโมชฺโช ",
      author: "หลวงพ่อปราโมทย์ ปาโมชฺโช ",
      vdos: [
        "https://youtu.be/giUC_Mm4xXc?si=94z9K3veEed6HxPJ",
        "https://youtu.be/Yay9d1lMI40?si=wdKvIkCmU7JSClPD",
        "https://www.youtube.com/live/7ZuZ5W8EQ1s?si=ubB6BDEXI-XJIOB-"
      ],
    ),
    Subject(
      id: 2,
      url:
          "https://youtube.com/playlist?list=PLcVbruXcGyJSXa791qg5ZW_X5W26vkgCj&si=wwhhVWHi8ORKe-eT",
      name: "01 ธรรมะนิยาย หลวงพ่อจรัญ เรื่องที่ 1 มักกะลีผล (ตอนทั้งหมด1-96)",
      author: "หลวงพ่อปราโมทย์ ปาโมชฺโช ",
      vdos: [
        "https://youtu.be/CkyQD0s5wFU?si=fSs3y_IsDSmhj4S5",
        "https://youtu.be/R6ThfSVyRrA?si=BLF5zkZmUWVeV8K2",
        "https://youtu.be/6Ksnifgve-k?si=mwpyUYN1rcRYGB3o"
      ],
    ),
    Subject(
      id: 3,
      url:
          "https://youtube.com/playlist?list=PLM5sAyJYOS6LNdTwiBQiI4UGUuBCUGL7f&si=L-wsRA_Q1laTVWu2",
      name: "DMC เพลงธรรมะ",
      author: "หลวงพ่อปราโมทย์ ปาโมชฺโช ",
      vdos: [
        "https://youtu.be/DOhpKvgtTKE?si=wLEqXpo958jNyxbO",
        "https://youtu.be/rLcXFjzpL1Y?si=tb3eQXtZ8X8FMy-I",
        "https://youtu.be/rLcXFjzpL1Y?si=m19R_V9CYynuVlQc"
      ],
    ),
    Subject(
      id: 4,
      url:
          "https://youtube.com/playlist?list=PLfwth3WMQnSMixTxh6NKIxqAGe89t-56H&si=r9BHuih3OchfsNCf",
      name: "RLCraft ครัวเหลี่ยมข้าวอร่อย",
      author: "พิมพ์เอง",
      vdos: [
        "https://youtu.be/hDEKU33U020?si=hDrPS6ZE4mdsNEJh",
        "https://youtu.be/FcQvAOyD9i8?si=TTV2r2Dn5_rfjhkq",
        "https://youtu.be/J__t_D2nTAU?si=88iZM2eKkIduChyA",
        "https://youtu.be/V4f5vAPR_VM?si=7aGnWxIZ26-onFf2"
      ],
    ),
  ]);

  @override
  void onInit() {
    super.onInit();
  }

  Future<yt.Video> fetchVideoData(String videoId) async {
    var ytClient = yt.YoutubeExplode();

    try {
      var video = await ytClient.videos.get(yt.VideoId(videoId));
      return video;
    } finally {
      ytClient.close();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
