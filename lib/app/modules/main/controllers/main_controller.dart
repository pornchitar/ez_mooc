import 'package:ez_mooc/services/subject_service.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  //TODO: Implement MainController
  RxInt currentIndex = 0.obs;
  RxInt selectedItem = 2.obs;
  @override
  void onInit() {
    super.onInit();
    Get.find<SubjectService>().fetchAllSubjects();
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
}
