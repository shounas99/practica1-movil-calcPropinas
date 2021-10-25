import 'package:flutter/material.dart';
import 'package:practica2/src/models/trailer_movies_model.dart';
import 'package:practica2/src/network/api_trailer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerCard extends StatefulWidget {
  //Variable para recibir id de la pelicula
  final String movieId;
  TrailerCard({Key? key, required this.movieId}) : super(key: key);
  // TrailerCard({Key? key}) : super(key: key);

  @override
  _TrailerCardState createState() => _TrailerCardState();
}

class _TrailerCardState extends State<TrailerCard> {
  late YoutubePlayerController _controller;
  //Inicializo mi API de trailer
  ApiTrailer apiTrailer = ApiTrailer();
  //initial State
  @override
  void initState(){
    _controller = YoutubePlayerController(
        initialVideoId: '${widget.movieId}',
        flags: YoutubePlayerFlags(
            mute: false,
            autoPlay: true,
        ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    print(widget.movieId);
 
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      onReady: () {
        print('Player is ready.');
      },
    );
  }

  

 
}