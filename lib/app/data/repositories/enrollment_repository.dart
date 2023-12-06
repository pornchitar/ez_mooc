import 'dart:convert';

import 'package:ez_mooc/app/data/model/enrollment_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

class EnrollmentRepository extends IRepository<Enrollment> {
  final url = 'https://4a67-49-228-185-23.ngrok-free.app/api';

  @override
  Future<void> delete(Enrollment t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Enrollment>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Enrollment?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> insert(Enrollment t) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<void> update(Enrollment t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  //get enrolments by userId
  Future<List<Enrollment>> getEnrolmentsByUserId(int userId) async {
    try {
      var response = await http.get(Uri.parse('$url/enrollments/$userId'));
      print('$url/enrollments/$userId');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);

        // Check if the 'data' key exists and is a map
        if (decodedResponse.containsKey('data') &&
            decodedResponse['data'] is Map<String, dynamic>) {
          Map<String, dynamic> enrollmentJson = decodedResponse['data'];

          // Create a single Enrollment object from the map
          Enrollment enrollment = Enrollment.fromJson(enrollmentJson);
          print(enrollment.toJson());

          return [enrollment];
        } else {
          print('Invalid response format - "data" is not a Map');
          throw Exception('Failed to load enrolments');
        }
      } else {
        print(
            'Failed to load enrolments - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load enrolments');
      }
    } catch (e) {
      print('Error fetching enrolments: $e');
      throw Exception('Failed to load enrolments');
    }
  }
}
