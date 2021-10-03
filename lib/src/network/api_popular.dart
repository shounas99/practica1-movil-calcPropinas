import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/models/popular_movies_model.dart';

class ApiPuopular {
  var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=b8c4186f13243344e6e4adcad1631e50&language=es-MX&page=1');
  Future<List<PopularMoviesModel>?> getAllPopular() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listPopular =
          popular.map((movie) => PopularMoviesModel.fromMap(movie)).toList();
    } else {
      return null;
    }
  }
}
