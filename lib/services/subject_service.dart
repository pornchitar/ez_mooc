import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:ez_mooc/app/data/repositories/subject_repository.dart';
import 'package:get/get.dart';

class SubjectService extends GetxService {
  final SubjectRepository subjectRepository = SubjectRepository();
  Rx<Subject> currentPlaylist = Subject(
          subjectId: 2,
          subjectName: "รวมเรื่องเล่า The Ghost Radio",
          description: "",
          // category: Category(
          //     categoryId: 1,
          //     categoryName: "ธรรมมะ",
          //     createdAt: '',
          //     updatedAt: '',
          //     categoryImage: ''),
          playlistLink:
              "https://youtube.com/playlist?list=PLESnSmimWaOyrrEncqo3tQZXWvu-13UwF&si=8Yz-rjkucAHVzRtN",
          videos: [
            VdoDetail(
              videoTitle:
                  '"เฮี้ยน" | คุณแก๊ป | 5 ก.พ. 17 | THE GHOST RADIO | เล่าเรื่องผีเดอะโกส',
              channelName: "The ghost",
              thumbnail: "https://img.youtube.com/vi/0byQ3wvcs58/0.jpg",
              subjectId: 2,
              videoURL: "https://youtu.be/0byQ3wvcs58?si=yFUZLyHABevJ_ROI",
              videoId: 3,
              videoCode: '0byQ3wvcs58',
              createdAt: '',
              updatedAt: '',
            ),
            VdoDetail(
              videoTitle:
                  'ห้องสนิม | คุณแป้ง | 6 ม.ค. 61 | ***น่ากลัวมากของปี 2561 THE GHOST RADIO | ฟังเรื่องผีเดอะโกส',
              channelName: "The ghost",
              thumbnail: "https://img.youtube.com/vi/R7ZCPM-Aufw/0.jpg",
              subjectId: 2,
              videoURL: 'https://youtu.be/R7ZCPM-Aufw?si=v4YvPAzLUEseC-cA',
              videoId: 4,
              videoCode: "R7ZCPM-Aufw",
              createdAt: '',
              updatedAt: '',
            ),
          ],
          categoryId: 1,
          createdAt: '',
          updatedAt: '')
      .obs;
  RxList<Subject> playlists = RxList<Subject>.of([
    Subject(
        subjectId: 2,
        subjectName: "รวมเรื่องเล่า The Ghost Radio",
        description: "",
        // category: Category(
        //     categoryId: 1,
        //     categoryName: "ธรรมมะ",
        //     createdAt: '',
        //     updatedAt: '',
        //     categoryImage: ''),
        playlistLink:
            "https://youtube.com/playlist?list=PLESnSmimWaOyrrEncqo3tQZXWvu-13UwF&si=8Yz-rjkucAHVzRtN",
        videos: [
          VdoDetail(
            videoTitle:
                '"เฮี้ยน" | คุณแก๊ป | 5 ก.พ. 17 | THE GHOST RADIO | เล่าเรื่องผีเดอะโกส',
            channelName: "The ghost",
            thumbnail: "https://img.youtube.com/vi/0byQ3wvcs58/0.jpg",
            subjectId: 2,
            videoURL: "https://youtu.be/0byQ3wvcs58?si=yFUZLyHABevJ_ROI",
            videoId: 3,
            videoCode: '0byQ3wvcs58',
            createdAt: '',
            updatedAt: '',
          ),
          VdoDetail(
            videoTitle:
                'ห้องสนิม | คุณแป้ง | 6 ม.ค. 61 | ***น่ากลัวมากของปี 2561 THE GHOST RADIO | ฟังเรื่องผีเดอะโกส',
            channelName: "The ghost",
            thumbnail: "https://img.youtube.com/vi/R7ZCPM-Aufw/0.jpg",
            subjectId: 2,
            videoURL: 'https://youtu.be/R7ZCPM-Aufw?si=v4YvPAzLUEseC-cA',
            videoId: 4,
            videoCode: "R7ZCPM-Aufw",
            createdAt: '',
            updatedAt: '',
          ),
        ],
        categoryId: 1,
        createdAt: '',
        updatedAt: ''),
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
      print("Subjects fetched: ${playlists.toJson()}");
    } catch (e) {
      print("Error fetching subjects: $e");
      // Handle exception, e.g., show an error message
    }
  }
}
