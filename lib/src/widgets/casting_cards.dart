
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/cast_movies_model.dart';
import 'package:practica2/src/network/api_cast.dart';

class CastingCards extends StatelessWidget {
  //Variable para recibir id de la pelicula
  final String movieId;
  const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Instancia Provider de peliculas
    ApiCast apiCast = ApiCast();
    // final movieCast = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      child: FutureBuilder(
        future: apiCast.getAllCast(movieId),
        builder: (BuildContext context, AsyncSnapshot<List<CastMoviesModel>?>snapshot){
          if (snapshot.hasError) {
            return Center(
              child: Text('Hay un error en peticion de actores'),
            );
          } else {
            if(snapshot.connectionState == ConnectionState.done){
              return _actores(snapshot.data);
            }else{
              return CircularProgressIndicator();
            }
          }
        }
      ),
    );
  }

  //widget actores
  Widget _actores(List<CastMoviesModel>? actores){
    return ListView.builder(
      itemCount: actores!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: ( _ ,int index){
        //Instanciar mi lista para acceder a mis datos
        CastMoviesModel actor = actores[index];

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 110,
          height: 100,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  
                  image: actor.profilePath != ''
                          ? NetworkImage('https://image.tmdb.org/t/p/w500/${actor.profilePath}') 
                          : NetworkImage('https://via.placeholder.com/150x300'), //'https://via.placeholder.com/150x300'
                  height: 140,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 5,),

              Text('${actor.name}', //'actor.name Cristina Aguilar'
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

