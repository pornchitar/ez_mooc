import 'package:get/get.dart';

class CategoryService extends GetxService {
  RxList<String> categories = RxList<String>.of([]).obs();

  //get categories
  List<String> get getCategories => categories.value;
  //set categories
  void setCategories(List<String> list) {
    categories.value = list;
  }
}
