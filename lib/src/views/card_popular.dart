import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';

import 'package:practica2/src/models/popular_movies_model.dart';

class CardPopularView extends StatelessWidget {
  final PopularMoviesModel popular; //Modelo de peliculas

  const CardPopularView({Key? key, required this.popular}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //Instancio mi DB
    DatabaseHelper _database =  DatabaseHelper();

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black87,
                offset: Offset(0.0, 5.0),
                blurRadius: 2.5)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: Hero(
                tag: popular.id!,
                child: FadeInImage(
                  placeholder: AssetImage('assets/activity_indicator.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${popular.backdropPath}'),
                  fadeInDuration: Duration(milliseconds: 200),
                ),
              ),
            ),
            Opacity(
              opacity: .5,
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                height: 55.0,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(popular.title!, style: TextStyle(color: Colors.white, fontSize: 12.0),),
                    MaterialButton(
                      onPressed: () async {

                        var checkMovieFav = await _database.showMovieFav(popular.id!);

                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'movieId'     : popular.id.toString(),
                            'title'       : popular.title,
                            'overview'    : popular.overview,
                            'posterpath'  : popular.posterPath,
                            'favorite'    : checkMovieFav
                          }
                        );
                      },
                      child: Icon(Icons.chevron_right, color: Colors.white,),
                    )
                  ],
                ),
              ),
            ) 
          ],
        )
      ),
    );
  }
}
