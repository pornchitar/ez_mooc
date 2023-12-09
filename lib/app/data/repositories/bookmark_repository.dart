import 'dart:convert';

import 'package:ez_mooc/app/data/model/bookMark_model.dart';
import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

class BookMarkRepository extends IRepository<BookMark> {
  final url = 'http://10.0.2.2:8000/api';

  @override
  Future<void> delete(BookMark t) {
    // TODO: implement delete
    throw UnimplementedError();
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
  Future<void> insert(BookMark t) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<void> update(BookMark t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  //get bookmark by user id
  Future<List<BookMark>> getBookMarkByUserId(int userId) async {
    try {
      var response = await http.get(Uri.parse('$url/bookmarks/$userId'));
      print('$url/bookmarks/$userId');

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
