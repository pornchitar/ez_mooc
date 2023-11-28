import 'package:get/get.dart';

import '../controllers/like_vdo_controller.dart';

class LikeVdoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LikeVdoController>(
      () => LikeVdoController(),
    );
  }
}
