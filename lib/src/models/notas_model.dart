class NotasModel {
  int? id;
  String? titulo;
  String? detalle;

  // NotasModel(int id, String titulo, String detalle) {
  //   this.id = id;
  //   this.titulo = titulo;
  //   this.detalle = detalle;
  // }

  NotasModel({this.id, this.titulo, this.detalle});

  //Constructor nombrado
  //Map -> Object. De mapa a Objecto. Y se pone al inicio la palabra factory
  factory NotasModel.fromMap(Map<String, dynamic> map) {
    return NotasModel(
        id: map['id'], titulo: map['titulo'], detalle: map['detalle']);
  }

  //Sirve cuando insertare datos a una DB
  //Object -> Map. De Objecto
  Map<String, dynamic> toMap() {
    return {'id': id, 'titulo': titulo, 'detalle': detalle};
  }
}
