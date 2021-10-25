import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/models/cast_movies_model.dart';

class ApiCast {
  Future<List<CastMoviesModel>?> getAllCast(String movieId)async{
  var URL = Uri.parse('https://api.themoviedb.org/3/movie/$movieId/credits?api_key=b8c4186f13243344e6e4adcad1631e50&language=es-MX&page=1');

    final response = await http.get(URL);
    if(response.statusCode == 200){
      var cast = jsonDecode(response.body)['cast'] as List;
      List<CastMoviesModel> listCast =
        cast.map((movieCast) => CastMoviesModel.fromMap(movieCast)).toList();
      return listCast;
    }else{
      return null;
    }
  }
}