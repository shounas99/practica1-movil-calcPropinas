import 'package:flutter/material.dart';
import 'package:practica2/src/providers/movie_fav_provider.dart';
import 'package:practica2/src/screens/movies_screen/movie_fav_screen.dart';
import 'package:practica2/src/screens/movies_screen/trailer_screen.dart';
import 'package:practica2/src/widgets/casting_cards.dart';
import 'package:practica2/src/network/api_cast.dart';

import 'package:practica2/src/providers/movies_provider.dart';
import 'package:practica2/src/widgets/trailer_card.dart';
import 'package:provider/provider.dart';

class DetailScrenn extends StatelessWidget {
  const DetailScrenn({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {  
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      //Inicio
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              CastingCards(movieId: movie['movieId'],) //movie['id']
            ])
          )
        ],
      ),
    );
  }
}

//Widget _CustomAppBar
class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SliverAppBar(
      backgroundColor: Colors.black12,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
          color: Colors.black12,
          child: Text(
            '${movie['title']}',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie['posterpath']}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


//Widget Titulo y poster
class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final size = MediaQuery.of(context).size;

    //Provider movies 
    final moviesProvider = Provider.of<MoviesProvider>(context);

    //Provider movies fav
    final moviesFavProvider = Provider.of<MovieFavProvider>(context);

    //Condicion si es favorita pelicula
    if(movie['favorite']){
      moviesFavProvider.setNoFavorite = true;
      movie['favorite'] = false;
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: movie['movieId'],
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie['posterpath']}'),
                height: 150,
              ),
            ),  
          ),
          SizedBox(width: 20,),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${movie['title']}', style: Theme.of(context).textTheme.headline5, maxLines: 2, overflow: TextOverflow.ellipsis,),
                //Puntuacion
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.yellow),
                    SizedBox(width: 5,),
                    Text('movie.voteAverage', style: Theme.of(context).textTheme.caption,)
                  ],
                ),
                //Marcar como fav
                Row(
                  children: [
                    IconButton( 
                      icon: Icon(
                        moviesFavProvider.favorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                        color: Colors.red
                      ),
                      onPressed: () async{
                          //Parseo de String a int
                          var movieId = int.parse(movie['movieId']);
                        if(!moviesFavProvider.favorite){
                          print('Id movie');
                          print(movie['movieId']);
                          moviesProvider.createMovieFav(
                            movieId,
                            movie['title'],
                            movie['overview'],
                            movie['posterpath']
                          );
                          moviesFavProvider.setFavorite = true;
                        } else{
                          await moviesProvider.deleteMovie(movieId);
                          moviesFavProvider.setFavorite = false;
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    Text('Marcar como favorito', style: Theme.of(context).textTheme.caption,),
                  ],
                ),
                //Ver peliculas fav
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.movie_filter_sharp, color: Colors.redAccent
                        ),
                      onPressed: () async {
                        await moviesProvider.refreshMovies();
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => new MovieFavScreen()));
                      },
                    ),
                    SizedBox(height: 10,),
                    Text('Peliculas favoritas', style: Theme.of(context).textTheme.caption,)
                  ],
                ),
                //Ver trailer
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.local_movies_sharp, color: Colors.indigoAccent,),
                      onPressed: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => new TrailerScreen(movieId: movie['movieId'])));
                      },
                    ),
                    SizedBox(height: 10,),
                    Text('Ver trailer', style: Theme.of(context).textTheme.caption,)
                  ],
                ), 
              ],
            ),
          )
        ],
      ),
    );
  }
}


//Widget Descripcion 
class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        '${movie['overview']}',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      )
    );
  }
}