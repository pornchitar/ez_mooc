import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:get/get.dart';

class VdoDetailService extends GetxService {
  RxList<VdoDetail> vdoPlaylists = RxList<VdoDetail>.of([]).obs();

  Rx<Subject> currentSubject = Subject(
    subjectId: 1,
    subjectName: "",
    description: "",
    playlistLink: "",
    vdoDetail: [],
  ).obs;
  Rx<VdoDetail> currentDetail = VdoDetail(
    id: 1,
    videoId: "",
    subjectId: 1,
    videoTitle: "",
    videoUrl: "",
    channelName: "",
    thumbnail: "",
  ).obs;
  RxString currentVdoUrl = "".obs;

  //get vdoPlaylists
  List<VdoDetail> getVdoPlaylists() {
    return vdoPlaylists.value;
  }

  //set vdoPlaylists
  void setVdoPlaylists(List<VdoDetail> list) {
    vdoPlaylists.value = list;
  }

  //get current vdo
  VdoDetail getCurrentVdo() {
    return currentDetail.value;
  }

  //set current vdo
  void setCurrentVdo(VdoDetail vdo) {
    currentDetail.value = vdo;
  }
}
