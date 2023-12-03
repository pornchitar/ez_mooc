import 'dart:convert';

import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

class CategoryRepository extends IRepository<Category> {
  final url = 'https://7b18-184-82-11-38.ngrok-free.app/api';
  @override
  Future<void> delete(Category t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getAll() async {
    try {
      var response = await http.get(Uri.parse('$url/categories'));
      print('$url/categories');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        List<dynamic> subjectsJson = decodedResponse['data'];
        List<Category> categories = subjectsJson
            .map((subjectJson) => Category.fromJson(subjectJson))
            .toList();
        return categories;
      } else {
        print(
            'Failed to load categories - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<Category?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> insert(Category t) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<void> update(Category t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
