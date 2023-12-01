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
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(SubjectService());
    Get.put(UserService());

    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => VdoDetailService());
    Get.lazyPut(() => EnrollmentService());
  }
}
