import 'dart:convert';

import 'package:ez_mooc/app/data/model/favorities_model.dart';
import 'package:ez_mooc/app/data/repositories/repository.dart';
import 'package:http/http.dart' as http;

class FavoritesRepository extends IRepository<Favorites> {
  final url = 'http://10.0.2.2:8000/api';

  @override
  Future<void> delete(Favorites t) async {
    final response = await http.delete(
      Uri.parse('$url/Favorites/${t.id}'), // replace with your actual endpoint
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Favorites');
    }
  }

  @override
  Future<void> insert(Favorites t) async {
    final response = await http.post(
      Uri.parse('$url/Favorites'), // replace with your actual endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'user_id': t.user.user_id, 'video_id': t.vdoDetail.videoId}),
    );

    if (response.statusCode == 201) {
      print('Favorites created successfully!');
      // return Favorites.fromJson(jsonDecode(response.body)['data']);
    } else {
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
