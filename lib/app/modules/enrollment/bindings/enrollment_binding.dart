import 'package:get/get.dart';

import '../controllers/enrollment_controller.dart';

class EnrollmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnrollmentController>(
      () => EnrollmentController(),
    );
  }
}
