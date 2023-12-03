import 'package:ez_mooc/app/data/model/category_model.dart';
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
      category: Category(
          categoryId: 1,
          categoryName: "",
          createdAt: '',
          updatedAt: '',
          categoryImage: ''),
      categoryId: 1,
      createdAt: '',
      updatedAt: '',
      videos: []).obs;
  Rx<VdoDetail> currentDetail = VdoDetail(
          videoId: 1,
          subjectId: 1,
          videoTitle: "",
          videoURL: "",
          thumbnail: "",
          channelName: "",
          videoCode: "",
          createdAt: "",
          updatedAt: "")
      .obs;
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
