import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt selectedItem = 2.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void changeSelectedItem(int index) {
    selectedItem.value = index;
  }

  @override
  void onClose() {}
}
