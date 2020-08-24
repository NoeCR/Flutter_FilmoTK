import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:filmotk/src/models/film_model.dart';

class FilmService {
  String _apiKey = '75dfbb4c6957e490b9fd37f72a6caa42';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Film>> _processResponse(Uri uri) async {
    final response = await http.get(uri);

    final decodedData = json.decode(response.body);

    final parsedFilms = Films.fromJsonList(decodedData['results']);

    return parsedFilms.films;
  }

  Future<List<Film>> getInTheaters() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _processResponse(url);
  }

  Future<List<Film>> getPopulars(String currentPage) async {
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': currentPage});

    return await _processResponse(url);
  }
}
