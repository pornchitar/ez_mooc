import 'package:ez_mooc/app/data/model/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class UserService extends GetxService {
  Rx<User> currentUser = User(id: "1", name: "แก้วมณี", lastName: "มารศรี").obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  void setCurrentUser(User user) {
    currentUser.value = user;
  }

  //get the current user
  User getCurrentUser() {
    return currentUser.value;
  }
}
