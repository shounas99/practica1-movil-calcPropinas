class ProfileModel {
  int? id;
  String? foto;
  String? nombre;
  String? apaterno;
  String? amaterno;
  String? telefono;
  String? correo;

  ProfileModel(
      {this.id,
      this.foto,
      this.nombre,
      this.apaterno,
      this.amaterno,
      this.telefono,
      this.correo});

  //De mapa a objeto, para recibir los datos
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
        id: map['id'],
        foto: map['foto'],
        nombre: map['nombre'],
        apaterno: map['apaterno'],
        amaterno: map['amaterno'],
        telefono: map['telefono'],
        correo: map['correo']);
  }

  //De objeto a mapa, para insertar los datos en la DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foto': foto,
      'nombre': nombre,
      'apaterno': apaterno,
      'amaterno': amaterno,
      'telefono': telefono,
      'correo': correo
    };
  }
}
