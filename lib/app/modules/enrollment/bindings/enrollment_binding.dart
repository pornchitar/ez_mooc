import 'package:ez_mooc/app/modules/home/controllers/home_controller.dart';
import 'package:ez_mooc/app/modules/vdo_page/controllers/vdo_page_controller.dart';
import 'package:get/get.dart';

import '../controllers/enrollment_controller.dart';

class EnrollmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnrollmentController>(
      () => EnrollmentController(),
    );
    Get.put(HomeController());
    Get.put(() => VdoPageController());
  }
}
