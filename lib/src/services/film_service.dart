import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:filmotk/src/models/film_model.dart';

class FilmService {
  String _apiKey = '75dfbb4c6957e490b9fd37f72a6caa42';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;
  bool _loading = false;
  // Declaración de variable para obtener el Future con los films y pasarlo al Stream
  List<Film> _populars = new List();
  // Controlador del Stream
  final _streamController = StreamController<List<Film>>.broadcast();
  // Adición de información tipada al Stream
  Function(List<Film>) get popularsSink => _streamController.sink.add;
  // Emisión de información tipada del Stream
  Stream<List<Film>> get popularsStream => _streamController.stream;

  void disposeStreams() {
    _streamController?.close();
  }

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

  Future<List<Film>> getPopulars() async {
    if (_loading) return [];
    _loading = true;
    _popularsPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });
    // Obtenemos los datos del Future
    final resp = await _processResponse(url);
    // Inicializamos la lista con la respuesta
    _populars.addAll(resp);
    //Añadimos la lista al Stream
    popularsSink(_populars);

    _loading = false;
    return resp;
  }
}
