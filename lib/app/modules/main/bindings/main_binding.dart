import 'package:ez_mooc/app/modules/enrollment/controllers/enrollment_controller.dart';
import 'package:ez_mooc/app/modules/history/controllers/history_controller.dart';
import 'package:ez_mooc/app/modules/home/controllers/home_controller.dart';
import 'package:ez_mooc/app/modules/likeVdo/controllers/like_vdo_controller.dart';
import 'package:ez_mooc/app/modules/playlist/controllers/playlist_controller.dart';
import 'package:ez_mooc/app/modules/profile/controllers/profile_controller.dart';
import 'package:ez_mooc/app/modules/vdo_page/controllers/vdo_page_controller.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.put(HomeController());
    Get.put(PlaylistController());
    Get.put(HistoryController());
    Get.put(LikeVdoController());
    Get.lazyPut(() => EnrollmentController());
    Get.put(ProfileController());
    Get.put(SubjectService());
    Get.put(UserService());
    Get.put(VdoDetailService());
    Get.lazyPut(() => EnrollmentService());
    Get.lazyPut(() => VdoPageController());
  }
}
