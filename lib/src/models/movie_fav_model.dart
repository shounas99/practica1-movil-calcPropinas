import 'dart:convert';

MovieFavModel movieFavModelFromJson(String str) => MovieFavModel.fromJson(json.decode(str));

String movieFavModel(MovieFavModel data) => json.encode(data.toJson());

class MovieFavModel{
  int? idMovie;
  String? title;
  String? overview;
  String? posterPath;

  MovieFavModel({this.idMovie, this.title, this.overview, this.posterPath});

  //De json a objeto para recibir datos
  factory MovieFavModel.fromJson(Map<String, dynamic>json){
    return MovieFavModel(
      idMovie   : json['idMovie'],
      title     : json['title'],
      overview  : json['overview'],
      posterPath: json['posterPath']
    );
  }
  //De objeto a json, esto para insertar los datos
  Map<String, dynamic> toJson(){
    return{
      'idMovie'   : idMovie,
      'title'     : title,
      'overview'  : overview,
      'posterPath': posterPath
    };
  }

  String toSting(){
    return '{ idMovie: ${this.idMovie}, title: ${this.title}, overview: ${this.overview}, posterPath: ${this.posterPath} }';
  }

}