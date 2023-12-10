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
      throw Exception('Failed to delete bookmark');
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
    final response = await http.post(
      Uri.parse('$url/bookmark'), // replace with your actual endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'user_id': t.user.user_id, 'video_id': t.vdoDetail.videoId}),
    );

    if (response.statusCode == 201) {
      print('Bookmark created successfully!');
      // return BookMark.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to create bookmark');
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
      var response = await http.get(Uri.parse('$url/bookmarks/user/$userId'));
      print('$url/bookmarks/user/$userId');

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
