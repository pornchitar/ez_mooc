//bookmark service
import 'package:ez_mooc/app/data/model/bookMark_model.dart';
import 'package:ez_mooc/app/data/repositories/bookmark_repository.dart';
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
      print('Bookmarks: ${this.bookmarks.value}');
    } catch (e) {
      print(e);
    }
  }
}
