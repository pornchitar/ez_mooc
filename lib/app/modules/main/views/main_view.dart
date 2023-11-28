import 'package:ez_mooc/app/modules/enrollment/views/enrollment_view.dart';
import 'package:ez_mooc/app/modules/history/views/history_view.dart';
import 'package:ez_mooc/app/modules/home/views/home_view.dart';
import 'package:ez_mooc/app/modules/likeVdo/views/like_vdo_view.dart';
import 'package:ez_mooc/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _getBody(controller.selectedItem.value);
      }),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.grey[300],
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: controller.selectedItem.value,
        onTap: (index) {
          controller.changeSelectedItem(index);
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
      ),
    );
  }

  Widget _getBody(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return EnrollmentView();
      case 1:
        return HistoryView();
      case 2:
        return HomeView();
      case 3:
        return LikeVdoView();
      case 4:
        return ProfileView();
      default:
        return Container(); // Handle default case or return an empty container.
    }
  }
}
