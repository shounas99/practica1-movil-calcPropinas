import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/profile_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProfile {
  static final _nameDB = "PROFILEDB";
  static final _versionDB = 1;
  static final _nameTBL = 'tblProfile';

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //Inicializar DB
  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nameDB);
    return openDatabase(rutaDB, version: _versionDB, onCreate: _createTable);
  }

  //Crear Tabla
  Future<void> _createTable(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_nameTBL (id INTEGER PRIMARY KEY, foto VARCHAR(500), nombre VARCHAR(50), apaterno VARCHAR(50), amaterno VARCHAR(50), telefono VARCHAR(50), correo VARCHAR(50))");
  }

  //Insertar
  Future<int> insert(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_nameTBL, row);
  }

  //Actualizar
  Future<int> update(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nameTBL, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  //Borrar
  Future<int> delete(int id) async {
    var conexion = await database;
    return await conexion!.delete(_nameTBL, where: 'id = ?', whereArgs: [id]);
  }

  //Obtener todos los perfiles
  Future<List<ProfileModel>> getAllProfiles() async {
    var conexion = await database;
    var result = await conexion!.query(_nameTBL);
    return result
        .map((profileMap) => ProfileModel.fromMap(profileMap))
        .toList();
  }

  //Obtener perfil
  Future<ProfileModel> getProfile(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nameTBL, where: 'id = ?', whereArgs: [id]);
    return ProfileModel.fromMap(result.first);
  }
}
