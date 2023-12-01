import 'package:ez_mooc/app/modules/vdo_page/controllers/vdo_page_controller.dart';
import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:get/get.dart';

class PlaylistController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    Get.find<VdoPageController>().disposeController();
    super.dispose();
  }
}
