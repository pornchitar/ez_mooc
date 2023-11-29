import 'dart:ffi';

import 'package:ez_mooc/app/data/model/enrollment_model.dart';
import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

class SubjectService extends GetxService {
  Rx<Subject> currentPlaylist =
      Subject(subjectId: 1, subjectName: "", description: "", playlistLink: "")
          .obs;
  RxList<Subject> playlists = RxList<Subject>.of([
    Subject(
        subjectId: 1,
        subjectName: "Mathematics",
        description: "Advanced Math",
        playlistLink:
            "https://youtube.com/playlist?list=PLth1DquOKn1Kqq_JJxL2laCnHtJ4JU1j7&si=HsjH3ZWrE-p8TjNc"),
    Subject(
        subjectId: 2,
        subjectName: "Science",
        description: "Physics and Chemistry",
        playlistLink:
            "https://youtube.com/playlist?list=PLESnSmimWaOyrrEncqo3tQZXWvu-13UwF&si=8Yz-rjkucAHVzRtN"),
  ]).obs();
  //get currentPlaylist
  Subject get getCurrentPlaylist => currentPlaylist.value;
  //get playlists
  List<Subject> get getPlaylists => playlists.value;
  //set playlists
  void setPlaylists(List<Subject> list) {
    playlists.value = list;
  }

  void setCurrentPlaylist(Subject playlist) {
    currentPlaylist.value = playlist;
  }
}
