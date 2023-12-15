import 'dart:convert';

import 'package:ez_mooc/app/data/model/bookMark_model.dart';
import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

class BookmarkRepository extends IRepository<BookMark> {
  final url = 'http://10.0.2.2:8000/api';

  @override
  Future<void> delete(BookMark t) async {
    final response = await http.delete(
      Uri.parse('$url/bookmark/${t.id}'), // replace with your actual endpoint
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Favorites');
    }
    if (response.statusCode == 200) {
      print('Favorites deleted successfully! Response: ${response.body}');
    }
  }

  @override
  Future<List<BookMark>> getAll() async {
    throw UnimplementedError();
  }

  @override
  Future<BookMark?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> insert(BookMark t) async {
    try {
      final response = await http.post(
        Uri.parse(
            '$url/bookmark'), // Assuming the endpoint is different for bookmarks
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'UserID': t.user.user_id,
          'VideoID': t.vdoDetail.videoId,
        }),
      );

      print('${response.statusCode}');
      if (response.statusCode == 201) {
        // Parse the response body
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Check if the 'data' key exists in the response
        if (responseData.containsKey('data')) {
          // Access the 'data' list from the response
          final List<dynamic> dataList = responseData['data'];

          // Check if the 'data' list is not empty
          if (dataList.isNotEmpty) {
            // Access the first element in the 'data' list
            final Map<String, dynamic> bookmarkData = dataList[0];

            // Access the 'id' field from the bookmark data
            final int bookmarkId = bookmarkData['id'];

            print('Bookmark created successfully! Response: ${response.body}');
            print('Bookmark ID: $bookmarkId');
          } else {
            // Handle the case where 'data' list is empty
            throw Exception('No data in the response');
          }
        } else {
          // Handle the case where 'data' key is not present in the response
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to create Bookmark');
      }
    } catch (e) {
      print('Error insert Bookmark: $e');
      throw Exception('Failed to create Bookmark');
    }
  }

  @override
  Future<void> update(BookMark t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  //get bookmark by user id
  Future<List<BookMark>> getBookMarkByUserId(int userId) async {
    try {
      var response = await http.get(Uri.parse('$url/bookmark/user/$userId'));
      print('$url/bookmark/user/$userId');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        List<dynamic> subjectsJson = decodedResponse['data'];
        List<BookMark> bookmarks = subjectsJson
            .map((subjectJson) => BookMark.fromJson(subjectJson))
            .toList();
        return bookmarks;
      } else {
        print('Failed to load bookmarks - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load bookmarks');
      }
    } catch (e) {
      print('Error fetching bookmarks: $e');
      throw Exception('Failed to load bookmarks');
    }
  }
}
