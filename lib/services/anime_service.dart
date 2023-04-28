import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seasonal_anime_app/models/anime.dart';

abstract class AnimeService {
  Future<List<Anime>> fetchCurrentSeasonAnime();
}

class AnimeServiceApi implements AnimeService {
  // final String _baseUrl = 'https://api.jikan.moe/v4/seasons/now';
  final String _baseUrl = 'https://api.example.com/v4/seasons/now';

  @override
  Future<List<Anime>> fetchCurrentSeasonAnime() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((jsonAnime) => Anime.fromJson(jsonAnime)).toList();
    } else {
      throw Exception('Failed to load seasonal anime');
    }
  }
}
