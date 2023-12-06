import 'dart:convert';

import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

class ProgessRepository extends IRepository<ProgressEnrollment> {
  final url = 'https://4a67-49-228-185-23.ngrok-free.app/api';

  @override
  Future<void> delete(ProgressEnrollment t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ProgressEnrollment>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<ProgressEnrollment?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> insert(ProgressEnrollment t) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<void> update(ProgressEnrollment t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  //get list progress  by user id
  Future<List<ProgressEnrollment>> getProgressByUserId(int userId) async {
    try {
      var response = await http.get(Uri.parse('$url/progress/$userId'));
      print('$url/progress/$userId');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);

        print('Decoded response: $decodedResponse');

        if (decodedResponse.containsKey('data')) {
          // Check if 'data' is a map
          if (decodedResponse['data'] is Map<String, dynamic>) {
            // Convert the single object to a list
            List<dynamic> progressJson = [decodedResponse['data']];
            List<ProgressEnrollment> progress = progressJson
                .map(
                    (progressJson) => ProgressEnrollment.fromJson(progressJson))
                .toList();
            return progress;
          } else {
            print('Invalid response format - "data" is not a Map');
            throw Exception('Failed to load progress');
          }
        } else {
          print('Invalid response format - "data" key not found');
          throw Exception('Failed to load progress');
        }
      } else {
        print('Failed to load progress - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load progress');
      }
    } catch (e) {
      print('Error fetching progress: $e');
      throw Exception('Failed to load progress');
    }
  }
}
