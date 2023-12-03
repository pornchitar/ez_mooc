import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/repositories/category_repository.dart';
import 'package:get/get.dart';

class CategoryService extends GetxService {
  RxList<Category> categories = RxList<Category>.of([]).obs();
  final CategoryRepository categoryRepository = CategoryRepository();

  //get categories
  List<Category> get getCategories => categories.value;
  //set categories
  void setCategories(List<Category> list) {
    categories.value = list;
  }

  //get categories from repository
  Future<void> fetchAllCategories() async {
    try {
      List<Category> fetchedCategories = await categoryRepository.getAll();
      categories.value = fetchedCategories;
      print("Subjects fetched: ${categories.toJson()}");
    } catch (e) {
      print("Error fetching subjects: $e");
      // Handle exception, e.g., show an error message
    }
  }
}
