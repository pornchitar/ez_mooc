import 'dart:convert';

import 'package:ez_mooc/app/data/model/favorities_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

final client = http.Client();

class FavoritesRepository extends IRepository<Favorites> {
  final url = 'http://10.0.2.2:8000/api';

  @override
  Future<void> delete(Favorites t) async {
    final response = await http.delete(
      Uri.parse('$url/favorites/${t.id}'), // replace with your actual endpoint
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Favorites');
    }
    if (response.statusCode == 200) {
      print('Favorites deleted successfully! Response: ${response.body}');
    }
  }

  // @override
  // Future<void> insert(Favorites t) async {
  //   try {
  //     print("--------------------------------");
  //     print('${t.toJson()}');
  //     // print body request
  //     print(jsonEncode({
  //       'UserID': t.user.user_id,
  //       'VideoID': t.vdoDetail.videoId,
  //     }));

  //     print("--------------------------------");

  //     final response = await client.post(
  //       Uri.parse('$url/favorites'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json'
  //       },
  //       body: jsonEncode({
  //         'UserID': t.user.user_id,
  //         'VideoID': t.vdoDetail.videoId,
  //       }),
  //     );

  //     print('${response.statusCode}');
  //     if (response.statusCode == 201) {
  //       print('Favorites created successfully! Response: ${response.body}');
  //     } else {
  //       throw Exception('Failed to create Favorites');
  //     }
  //   } catch (e) {
  //     print('Error insert Favorites: $e');
  //     throw Exception('Failed to create Favorites');
  //   }
  // }
  @override
  Future<void> insert(Favorites t) async {
    try {
      final response = await client.post(
        Uri.parse('$url/favorites'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
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
            final Map<String, dynamic> favoriteData = dataList[0];

            // Access the 'id' field from the favorite data
            final int favoriteId = favoriteData['id'];

            print('Favorites created successfully! Response: ${response.body}');
            print('Favorite ID: $favoriteId');
          } else {
            // Handle the case where 'data' list is empty
            throw Exception('No data in the response');
          }
        } else {
          // Handle the case where 'data' key is not present in the response
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to create Favorites');
      }
    } catch (e) {
      print('Error insert Favorites: $e');
      throw Exception('Failed to create Favorites');
    }
  }

  @override
  Future<List<Favorites>> getAll() async {
    throw UnimplementedError();
  }

  @override
  Future<Favorites?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> update(Favorites t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  //get Favorites by user id
  Future<List<Favorites>> getFavoritesByUserId(int userId) async {
    try {
      var response = await http.get(Uri.parse('$url/favorites/user/$userId'));
      print('$url/favorites/user/$userId');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);

        List<dynamic> subjectsJson = decodedResponse['data'];

        List<Favorites> favorites = subjectsJson
            .map((subjectJson) => Favorites.fromJson(subjectJson))
            .toList();

        return favorites;
      } else {
        print('Failed to load Favorites - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load Favorites');
      }
    } catch (e) {
      print('Error fetching Favorites: $e');
      throw Exception('Failed to load Favorites');
    }
  }
}
