import 'dart:ffi';

import 'package:ez_mooc/services/favorites_service.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

class LikeVdoController extends GetxController {
  //TODO: Implement LikeVdoController
  final favoritesService = FavoritesService();

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
