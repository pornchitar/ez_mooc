import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/modules/vdo_page/controllers/vdo_page_controller.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class HomeController extends GetxController {
  RxList<Subject> playlists = RxList<Subject>.of([]);
  RxList<Category> playlistsCat = RxList<Category>.of([]);

  @override
  void onInit() {
    super.onInit();
    SubjectService().fetchAllSubjects();
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

  @override
  void dispose() {
    Get.find<VdoPageController>().disposeController();
    super.dispose();
  }
}
