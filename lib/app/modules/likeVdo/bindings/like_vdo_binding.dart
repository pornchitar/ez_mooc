import 'package:ez_mooc/services/favorites_service.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

import '../controllers/like_vdo_controller.dart';

class LikeVdoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LikeVdoController>(
      () => LikeVdoController(),
    );
    Get.put(UserService());

    Get.lazyPut(() => FavoritesService());
  }
}
