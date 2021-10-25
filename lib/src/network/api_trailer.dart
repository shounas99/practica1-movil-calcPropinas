import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/models/trailer_movies_model.dart';

class ApiTrailer{

  Future<List<TrailerMoviesModel>?> getTrailer(String movieId)async{
  var URL = Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos?api_key=b8c4186f13243344e6e4adcad1631e50&language=es-MX');
    final response = await http.get(URL);
    if(response.statusCode == 200){
      var trailer = jsonDecode(response.body)['results'] as List;
      List<TrailerMoviesModel> listTrailer = trailer.map((movieTrailer) => TrailerMoviesModel.fromMap(movieTrailer)).toList();
      return listTrailer;
    }else{
      return null;
    }
  }
}