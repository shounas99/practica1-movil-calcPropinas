
import 'package:flutter/cupertino.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/movie_fav_model.dart';

class MoviesProvider extends ChangeNotifier{
  //Instancia de mi DB
  DatabaseHelper db = DatabaseHelper();
  //Mi obj de movies
  List<MovieFavModel> movies = [];

  //Insertar movies Fav
  createMovieFav(int idMovie, String title, String overview, String posterPath)async{
    final newMovieFav = MovieFavModel(
      idMovie   : idMovie,
      title     : title,
      overview  : overview,
      posterPath: posterPath
    );
    final newMovieFavId = await db.insertMovieFav(newMovieFav);
    newMovieFav.idMovie = newMovieFavId;
    notifyListeners();
  }

  //Mostrar Movies fav
  refreshMovies() async{
    final movies = await db.getMoviesFav();
    this.movies = [...movies];
    notifyListeners();
  }
  //Eliminar movies fav
  deleteMovie(int idMovie) async{
    await db.deleteMovieFav(idMovie);
    movies.removeWhere((deleteMovieFav) => deleteMovieFav.idMovie == idMovie);
    notifyListeners();
  }


}