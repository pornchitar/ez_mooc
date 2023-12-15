import 'package:ez_mooc/services/bookmark_service.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.find<BookmarksService>().fetchBookmarksByUserId(
        Get.find<UserService>().currentUser.value.user_id);
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
