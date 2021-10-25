import 'package:flutter/material.dart';
import 'package:practica2/src/models/trailer_movies_model.dart';
import 'package:practica2/src/network/api_trailer.dart';
import 'package:practica2/src/widgets/trailer_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatelessWidget {
  final String movieId;
  const TrailerScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiTrailer apiTrailer = ApiTrailer();
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: apiTrailer.getTrailer(movieId),
          builder: (BuildContext context, AsyncSnapshot<List<TrailerMoviesModel>?>snapshot){
            if (snapshot.hasError) {
              return Center(
                child: Text('Hay un error en peticion de actores'),
              );
            } else {
              if(snapshot.connectionState == ConnectionState.done){
                return _trailers(snapshot.data!);
              }else{
                return CircularProgressIndicator();
              }
            }
          }
        ),
      )
    );
  }

  //Widget de trailers
   Widget _trailers(List<TrailerMoviesModel> trailers){
    var getKey = trailers[0].key;

    return TrailerCard(movieId: getKey!);
  }
}