import 'package:ez_mooc/services/bookmark_service.dart';
import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
    Get.put(BookmarksService());
  }
}
