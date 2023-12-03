import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/app/data/repositories/subject_repository.dart';
import 'package:get/get.dart';

class SubjectService extends GetxService {
  final SubjectRepository subjectRepository = SubjectRepository();
  Rx<Subject> currentPlaylist = Subject(
      subjectId: 1,
      subjectName: "",
      description: "",
      playlistLink: "",
      category: Category(categoryId: 1, categoryName: "ทำอาหาร"),
      vdoDetail: []).obs;
  RxList<Subject> playlists = RxList<Subject>.of([
    Subject(
        subjectId: 1,
        subjectName: "RLCraft ครัวเหลี่ยมข้าวอร่อย",
        description: "",
        category: Category(categoryId: 1, categoryName: "ทำอาหาร"),
        playlistLink:
            "https://youtube.com/playlist?list=PLfwth3WMQnSMixTxh6NKIxqAGe89t-56H&si=_ZX5xBAIeCx2BDgN",
        vdoDetail: [
          VdoDetail(
            id: 1,
            videoId: "hDEKU33U020",
            videoTitle:
                'ชายผู้เติมไวที่สุด | RLCraft ครัวเหลี่ยมข้าวอร่อย EP.1',
            videoUrl: "https://youtu.be/hDEKU33U020?si=wXMVb1cwt9XAeuJ2",
            channelName: "Gssspotted",
            thumbnail: "https://img.youtube.com/vi/hDEKU33U020/0.jpg",
          ),
          VdoDetail(
            id: 2,
            videoId: "FcQvAOyD9i8",
            videoTitle: 'บ้านนี้เจ้าที่แรง | RLCraft ครัวเหลี่ยมข้าวอร่อย EP.2',
            videoUrl: "https://youtu.be/FcQvAOyD9i8?si=cvmS35f4tikHhqSf",
            channelName: "Gssspotted",
            thumbnail: "https://img.youtube.com/vi/R7ZCPM-Aufw/0.jpg",
          ),
        ]),
    Subject(
        subjectId: 2,
        subjectName: "รวมเรื่องเล่า The Ghost Radio",
        description: "",
        category: Category(categoryId: 1, categoryName: "ธรรมมะ"),
        playlistLink:
            "https://youtube.com/playlist?list=PLESnSmimWaOyrrEncqo3tQZXWvu-13UwF&si=8Yz-rjkucAHVzRtN",
        vdoDetail: [
          VdoDetail(
            id: 3,
            videoId: "0byQ3wvcs58",
            videoTitle:
                '"เฮี้ยน" | คุณแก๊ป | 5 ก.พ. 17 | THE GHOST RADIO | เล่าเรื่องผีเดอะโกส',
            videoUrl: "https://youtu.be/0byQ3wvcs58?si=yFUZLyHABevJ_ROI",
            channelName: "The ghost",
            thumbnail: "https://img.youtube.com/vi/0byQ3wvcs58/0.jpg",
          ),
          VdoDetail(
            id: 4,
            videoId: "R7ZCPM-Aufw",
            videoTitle:
                'ห้องสนิม | คุณแป้ง | 6 ม.ค. 61 | ***น่ากลัวมากของปี 2561 THE GHOST RADIO | ฟังเรื่องผีเดอะโกส',
            videoUrl: "https://youtu.be/R7ZCPM-Aufw?si=v4YvPAzLUEseC-cA",
            channelName: "The ghost",
            thumbnail: "https://img.youtube.com/vi/R7ZCPM-Aufw/0.jpg",
          ),
        ]),
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

  Future<void> fetchAllSubjects() async {
    try {
      List<Subject> fetchedSubjects = await subjectRepository.getAll();
      playlists.value = fetchedSubjects;
      print("Subjects fetched: ${playlists.length}");
    } catch (e) {
      print("Error fetching subjects: $e");
      // Handle exception, e.g., show an error message
    }
  }
}
