import 'package:ez_mooc/app/modules/vdo_page/controllers/vdo_page_controller.dart';
import 'package:get/get.dart';

class EnrollmentController extends GetxController {
  //TODO: Implement EnrollmentController

  final count = 0.obs;
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

  void increment() => count.value++;
}
