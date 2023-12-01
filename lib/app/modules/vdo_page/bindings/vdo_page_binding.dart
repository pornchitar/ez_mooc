import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/home_service.dart';
import 'package:get/get.dart';

import '../controllers/vdo_page_controller.dart';

class VdoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VdoPageController>(
      () => VdoPageController(),
    );
    Get.put(NavigationController());
  }
}
