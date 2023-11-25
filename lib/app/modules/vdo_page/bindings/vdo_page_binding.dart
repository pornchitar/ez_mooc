import 'package:get/get.dart';

import '../controllers/vdo_page_controller.dart';

class VdoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VdoPageController>(
      () => VdoPageController(),
    );
  }
}
