import 'package:flutter/material.dart';
import 'package:practica2/src/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieFavScreen extends StatelessWidget {
  const MovieFavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Provider movies fav
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final movies = moviesProvider.movies;

    // final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis peliculas favoritas'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
          child: Card(
            elevation: 10.0,
            child: Column(
              children: [
                Text('${movies[index].title}'),
                Row(
                  children: [
                    FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: NetworkImage('https://image.tmdb.org/t/p/w500/${movies[index].posterPath}',),
                      height: 140,
                      width: 100,
                      
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    '${movies[index].overview}',
                    textAlign: TextAlign.justify,
                  ),
                )
                
              ],
            ),
            
          ),
        )
      ) ,
      
      // backgroundColor: Colors.bla,
      
    );
  }
}