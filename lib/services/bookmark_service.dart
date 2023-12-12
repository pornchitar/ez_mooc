//bookmark service
import 'package:ez_mooc/app/data/model/bookMark_model.dart';
import 'package:ez_mooc/app/data/repositories/bookmark_repository.dart';
import 'package:ez_mooc/services/user_service.dart';
import 'package:get/get.dart';

class BookmarksService extends GetxService {
  final bookmarkRepository = BookmarkRepository();
  RxList<BookMark> bookmarks = RxList<BookMark>.of([]).obs();

  //get bookmarks
  List<BookMark> getBookmarks() {
    return this.bookmarks.value;
  }

  //set bookmarks
  void setBookmarks(List<BookMark> bookmarks) {
    this.bookmarks.clear();
    this.bookmarks.addAll(bookmarks);
  }

  //get bookmarks from repository by user id
  Future<void> fetchBookmarksByUserId(int userId) async {
    try {
      List<BookMark> bookmarks =
          await bookmarkRepository.getBookMarkByUserId(userId);
      this.bookmarks.value = bookmarks;
      print('Bookmarks: ${this.bookmarks.toList().map((e) => e.toJson())}');
    } catch (e) {
      print(e);
    }
  }

  Future<void> createBookmark(BookMark bookMark) async {
    try {
      final bookmark = await bookmarkRepository.insert(bookMark);
      fetchBookmarksByUserId(
          Get.find<UserService>().currentUser.value.user_id!);
    } catch (e) {
      // Handle errors or propagate them
      rethrow;
    }
  }

  Future<void> deleteBookmark(BookMark bookMark) async {
    try {
      await bookmarkRepository.delete(bookMark);
      fetchBookmarksByUserId(
          Get.find<UserService>().currentUser.value.user_id!);
    } catch (e) {
      // Handle errors or propagate them
      rethrow;
    }
  }
}
