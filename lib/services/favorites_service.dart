//bookmark service
import 'package:ez_mooc/app/data/model/favorities_model.dart';
import 'package:ez_mooc/app/data/repositories/favorities_repository.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

class FavoritesService extends GetxService {
  final favoritesRepository = FavoritesRepository();
  RxList<Favorites> favorites = RxList<Favorites>.of([]).obs();
  //get
  List<Favorites> getFavorites() {
    return this.favorites.value;
  }

  //set
  void setFavorites(List<Favorites> favorites) {
    this.favorites.clear();
    this.favorites.addAll(favorites);
  }

  //get favorites from repository by user id
  Future<void> fetchFavoritesByUserId(int userId) async {
    try {
      List<Favorites> favorites =
          await favoritesRepository.getFavoritesByUserId(userId);
      this.favorites.value = favorites;
      print('Favorites: ${this.favorites.value}');
    } catch (e) {
      print(e);
    }
  }

  Future<void> createBookmark(Favorites favorites) async {
    try {
      final bookmark = await favoritesRepository.insert(favorites);
      // Additional logic if needed
      fetchFavoritesByUserId(
          Get.find<UserService>().currentUser.value.user_id!);
    } catch (e) {
      // Handle errors or propagate them
      rethrow;
    }
  }

  Future<void> deleteBookmark(Favorites favorites) async {
    try {
      await favoritesRepository.delete(favorites);
      fetchFavoritesByUserId(
          Get.find<UserService>().currentUser.value.user_id!);
      // Additional logic if needed
    } catch (e) {
      // Handle errors or propagate them
      rethrow;
    }
  }
}
