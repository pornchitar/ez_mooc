import 'package:ez_mooc/services/enrollment_service.dart';
import 'package:ez_mooc/services/home_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:ez_mooc/services/vdo_detail_service.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserService()); // Changed to lazyPut for consistency
    Get.lazyPut(
        () => SubjectService()); // Moved before HomeController initialization
    Get.lazyPut(() => VdoDetailService());
    Get.lazyPut(() => EnrollmentService());
    Get.lazyPut<HomeController>(
        () => HomeController()); // Ensure this is after all required services
  }
}
