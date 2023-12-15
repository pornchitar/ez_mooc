import 'dart:convert';

import 'package:ez_mooc/app/data/model/report_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProgessRepository extends IRepository<ProgressEnrollment> {
  final url = 'http://10.0.2.2:8000/api';

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
  Future<void> update(ProgressEnrollment t) async {
    // update progress by id
    try {
      var response =
          await http.put(Uri.parse('$url/progress/${t.progressId}'), body: {
        'progressId': '${t.progressId}',
        'enrollmentId': '${t.enrollmentId}',
        'videoId': '${t.videoId}',
      });
      print('$url/progress/${t.progressId}');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        print(decodedResponse['data']);
      } else {
        print(
            'Failed to update progress - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update progress');
      }
    } catch (e) {
      print('Error update progress: $e');
      throw Exception('Failed to update progress');
    }
  }

  //update persentage progress
  Future<void> updatePersentageProgress(
      ProgressEnrollment progressEnrollment) async {
    print(
        "{'ProgressID': ${progressEnrollment.progressId},'ProgressPercentage': ${progressEnrollment.progressPercentage}}");
    try {
      var response = await http.put(
        Uri.parse('$url/progress/percentage/${progressEnrollment.progressId}'),
        body: {
          "ProgressID": progressEnrollment.progressId.toString(),
          "ProgressPercentage": progressEnrollment.progressPercentage.toString()
        },
      );

      print('$url/progress/percentage');

      if (response.statusCode == 200) {
        print("Success update progress");
      } else {
        print(
            'Failed to update progress - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update progress');
      }
    } catch (e) {
      print('Error updating progress: $e');
      throw Exception('Failed to update progress');
    }
  }

  //get list progress  by user id
  Future<List<ProgressEnrollment>> getProgressByUserId(int userId) async {
    try {
      var response = await http.get(Uri.parse('$url/progress/user/$userId'));
      print('$url/progress');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        List<dynamic> subjectsJson = decodedResponse['data'];
        List<ProgressEnrollment> progress = subjectsJson
            .map((subjectJson) => ProgressEnrollment.fromJson(subjectJson))
            .toList();

        return progress;
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
