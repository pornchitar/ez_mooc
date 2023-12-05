import 'dart:convert';
import 'package:ez_mooc/app/data/model/subject_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

class SubjectRepository extends IRepository<Subject> {
  final url = 'https://22b7-49-228-121-127.ngrok-free.app/api';

  @override
  Future<void> insert(Subject t) async {
    var response = await http.post(
      Uri.parse('$url/subjects'), // Adjust endpoint as necessary
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(t.toJson()), // Assuming Subject has a toJson method
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to insert subject');
    }
  }

  @override
  Future<List<Subject>> getAll() async {
    try {
      var response = await http.get(Uri.parse('$url/subjects'));
      print('$url/subjects');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        List<dynamic> subjectsJson = decodedResponse['data'];
        List<Subject> subjects = subjectsJson
            .map((subjectJson) => Subject.fromJson(subjectJson))
            .toList();

        return subjects;
      } else {
        print('Failed to load subjects - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load subjects');
      }
    } catch (e) {
      print('Error fetching subjects: $e');
      throw Exception('Failed to load subjects');
    }
  }

  @override
  Future<Subject?> getOne(int id) async {
    var response = await http.get(Uri.parse('$url/subjects/$id'));
    if (response.statusCode == 200) {
      return Subject.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load subject');
    }
  }

  @override
  Future<void> update(Subject t) async {
    var response = await http.put(
      Uri.parse(
          '$url/subjects/${t.subjectId}'), // Replace with your subject ID field
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(t.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update subject');
    }
  }

  @override
  Future<void> delete(Subject t) async {
    var response = await http.delete(
      Uri.parse(
          '$url/subjects/${t.subjectId}'), // Replace with your subject ID field
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete subject');
    }
  }
}
