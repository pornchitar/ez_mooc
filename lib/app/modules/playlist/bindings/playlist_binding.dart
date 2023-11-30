import 'package:ez_mooc/app/modules/vdo_page/controllers/vdo_page_controller.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/home_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';

import '../controllers/playlist_controller.dart';

class PlaylistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlaylistController>(
      () => PlaylistController(),
    );
    Get.put(SubjectService());
    Get.put(EnrollmentService());
    Get.put(NavigationController());

    Get.lazyPut(() => VdoDetailService());
    Get.lazyPut(() => PlaylistController());
    Get.lazyPut(() => VdoPageController());
  }
}
