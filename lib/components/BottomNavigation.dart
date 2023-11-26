import 'package:ez_mooc/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the controller or service
    var controller = Get.find<NavigationController>();

    return GetBuilder<NavigationController>(
      init: controller, // Initialize the controller if not done elsewhere
      builder: (controller) {
        // Check if the controller is not null
        if (controller != null) {
          return BottomNavigationBar(
            unselectedItemColor: Colors.black54,
            backgroundColor: Colors.grey[300],
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 0.0,
            unselectedFontSize: 0.0,
            currentIndex: controller.selectedItem.value,
            onTap: (index) {
              controller.changeSelectedItem(index);
              if (controller.selectedItem.value == 2) {
                Get.offAllNamed('/home');
              } else if (controller.selectedItem.value == 0) {
                Get.offAllNamed('/enrollment');
              } else if (controller.selectedItem.value == 3) {
                Get.toNamed('/history');
              } else if (controller.selectedItem.value == 4) {
                Get.offAllNamed('/profile');
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 45.0),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2),
                label: '',
              ),
            ],
          );
        } else {
          // Controller is null, return an empty container or handle accordingly
          return Container();
        }
      },
    );
  }
}
