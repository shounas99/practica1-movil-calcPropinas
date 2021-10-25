import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/movie_fav_model.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DatabaseHelper {
  static final _nombreBD = "NOTASBD";
  static final _versionBD = 1;
  static final _nombreTBL = "tblNotas";
  static final _nameTBL2 = "tblMoviesFav";

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  //--------------------Inicializo DB--------------------
  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, _nombreBD);
    return openDatabase(rutaBD, version: _versionBD, onCreate: _crearTabla);
  }
  //-------------------Creacion de tablas-------------------
  Future<void> _crearTabla(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_nombreTBL (id INTEGER PRIMARY KEY,titulo VARCHAR(50), detalle VARCHAR(100))",);
    await db.execute('''
    CREATE TABLE $_nameTBL2 (
      idMovie INT NOT NULL,
      title TEXT NOT NULL,
      overview TEXT NOT NULL,
      posterPath TEXT NOT NULL
      )
    ''');
  
  }
  //--------------NOTAS-----------------
  Future<int> insert(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_nombreTBL, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nombreTBL, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var conexion = await database;
    return await conexion!.delete(_nombreTBL, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<NotasModel>> getAllNotes() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result.map((notaMap) => NotasModel.fromMap(notaMap)).toList();
  }

  Future<NotasModel> getNote(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nombreTBL, where: 'id=?', whereArgs: [id]);
    //result.map((notaMap) => NotasModel.fromMap(notaMap)).first;
    return NotasModel.fromMap(result.first);
  }

  //-------------------Insertar movies fav-------------------
  Future<int> insertMovieFav(MovieFavModel movieFavModel)async {
    final conexion = await database;
    final result = await conexion!.insert(_nameTBL2, movieFavModel.toJson());
    return result;
  }


  //-------------------Obtener movies fav-------------------
  Future<List<MovieFavModel>> getMoviesFav() async {
    var conexion = await database;
    var result = await conexion!
        .query(_nameTBL2);
    return result.map((movieMap) => MovieFavModel.fromJson(movieMap)).toList();
  }

  //-------------------Eliminar movies fav-------------------
   Future<int> deleteMovieFav(int idMovie)async{
    var conexion = await database;
    var result = await conexion!.delete(_nameTBL2, where: 'idMovie = ?', whereArgs: [idMovie]);
    return result;
  }
  //-------------------Ver movies fav-------------------
  showMovieFav(int idMovie) async{
    var conexion = await database;
    var result = await conexion!.rawQuery('''
      SELECT idMovie FROM $_nameTBL2
      WHERE idMovie = '$idMovie'
    ''');
    if(result.toString().length > 2){
      return true;
    } else{
      return false;
    }
  }
}
