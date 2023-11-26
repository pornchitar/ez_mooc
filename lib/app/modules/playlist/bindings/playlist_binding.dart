import 'package:ez_mooc/services/home_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:get/get.dart';

import '../controllers/playlist_controller.dart';

class PlaylistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaylistController>(
      () => PlaylistController(),
    );
    Get.put(SubjectService());
    Get.put(NavigationController());
  }
}
