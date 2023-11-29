import 'package:ez_mooc/app/data/model/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class UserService extends GetxService {
  Rx<User> currentUser = User(
          user_id: 1,
          user_name: "แก้วมณี",
          user_password: "1234",
          image:
              "https://scontent.fbkk10-1.fna.fbcdn.net/v/t39.30808-6/405922166_373879861806448_1644833663208942731_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGluYrQRNCwlfbQJDL1PfpsZEAU2-kZZlVkQBTb6RlmVSVskOfyqVrMFE7CUfJmODsmVHUnxeSRghrxHHMrVOuZ&_nc_ohc=FVHGpoZDorkAX-KyiNG&_nc_ht=scontent.fbkk10-1.fna&oh=00_AfAHWRZd0XFflYGEFxgBfkWf6ApoVF_EZRBjGZ_AFOi_mg&oe=656B8E8F",
          user_phone: "0815593836",
          created_at: DateTime.now(),
          role: "student")
      .obs;

  void setCurrentUser(User user) {
    currentUser.value = user;
  }

  User getCurrentUser() {
    return currentUser.value;
  }
}
