import 'package:ez_mooc/services/category_service.dart';
import 'package:ez_mooc/services/subject_service.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MainController extends GetxController {
  //TODO: Implement MainController
  RxInt currentIndex = 0.obs;
  RxInt selectedItem = 2.obs;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void onInit() {
    super.onInit();
    Get.find<SubjectService>().fetchAllSubjects();
    Get.find<CategoryService>().fetchAllCategories();
  }

  void changeSelectedItem(int index) {
    selectedItem.value = index;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logEvent(String eventName, Map<String, dynamic> parameters) async {
    await _analytics.logEvent(name: eventName, parameters: parameters);
  }
}
