import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_setting.dart';
import 'package:practica2/src/models/profile_model.dart';
import 'package:practica2/src/database/database_profile.dart';

import 'package:image_picker/image_picker.dart';

class AgregarProfileScreen extends StatefulWidget {
  //Variable profile -> recibira lo que le mande a mi constructor, mi objeto para editar
  ProfileModel? profile;
  AgregarProfileScreen({Key? key, this.profile}) : super(key: key);

  @override
  _AgregarProfileScreenState createState() => _AgregarProfileScreenState();
}

class _AgregarProfileScreenState extends State<AgregarProfileScreen> {
  late DatabaseProfile _databaseProfile;
  File? _imagen;
  String? _rutaImagen;

  TextEditingController _controllerFoto = TextEditingController();
  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerApaterno = TextEditingController();
  TextEditingController _controllerAmaterno = TextEditingController();
  TextEditingController _controlllerTelefono = TextEditingController();
  TextEditingController _controllerCorreo = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.profile != null) {
      _controllerFoto.text = widget.profile!.foto!;
      _controllerNombre.text = widget.profile!.nombre!;
      _controllerApaterno.text = widget.profile!.apaterno!;
      _controllerAmaterno.text = widget.profile!.amaterno!;
      _controlllerTelefono.text = widget.profile!.telefono!;
      _controllerCorreo.text = widget.profile!.correo!;
    }
    _databaseProfile = DatabaseProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.profile == null
            ? Text('Datos usuario')
            : Text('Editar datos'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: [
          _crearFoto(),
          Divider(),
          _mostrarFoto(),
          Divider(),
          _crearTextFieldNombre(),
          Divider(),
          _crearTextFieldApaterno(),
          Divider(),
          _crearTextFieldAmaterno(),
          Divider(),
          _crearTextFieldTelefono(),
          Divider(),
          _crearTextFieldCorreo(),
          _botonGuardar()
        ],
      ),
    );
  }

  Widget _mostrarFoto() {
    return Center(
      child: _imagen != null
          ? Image.file(
              _imagen!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            )
          : Text('No hay avatar'),
    );
  }

  Widget _crearFoto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () {
              _tomarFoto(ImageSource.camera);
            },
            child: Icon(
              Icons.camera,
            )),
        ElevatedButton(
            onPressed: () {
              _tomarFoto(ImageSource.gallery);
            },
            child: Icon(Icons.image)),
      ],
    );
  }

  Widget _crearTextFieldNombre() {
    return TextField(
      controller: _controllerNombre,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Nombre',
          labelText: 'Nombre',
          icon: Icon(Icons.face)),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldApaterno() {
    return TextField(
      controller: _controllerApaterno,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Apellido paterno',
          labelText: 'Apellido paterno',
          icon: Icon(Icons.face)),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldAmaterno() {
    return TextField(
      controller: _controllerAmaterno,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Apellido materno',
          labelText: 'Apellido materno',
          icon: Icon(Icons.face)),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldTelefono() {
    return TextField(
      controller: _controlllerTelefono,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Número de Teléfono',
          labelText: 'Número de Teléfono',
          icon: Icon(Icons.phone)),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldCorreo() {
    return TextField(
      controller: _controllerCorreo,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Correo electrónico',
          labelText: 'Correo electrónico',
          icon: Icon(Icons.email)),
      onChanged: (value) {},
    );
  }

  Widget _botonGuardar() {
    return ElevatedButton(
      onPressed: () {
        if (widget.profile == null) {
          //
          ProfileModel profile = ProfileModel(
            foto: _rutaImagen,
            nombre: _controllerNombre.text,
            apaterno: _controllerApaterno.text,
            amaterno: _controllerAmaterno.text,
            telefono: _controlllerTelefono.text,
            correo: _controllerCorreo.text,
          );

          _databaseProfile.insert(profile.toMap()).then((value) {
            if (value > 0) {
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No se completo el registro')));
            }
          });
          //
        } else {
          ProfileModel profile = ProfileModel(
              id: widget.profile!.id,
              foto: _rutaImagen,
              nombre: _controllerNombre.text,
              apaterno: _controllerApaterno.text,
              amaterno: _controllerAmaterno.text,
              telefono: _controlllerTelefono.text,
              correo: _controllerCorreo.text);

          _databaseProfile.update(profile.toMap()).then((value) {
            if (value > 0) {
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No se completo el registro')));
            }
          });
        }
      },
      child: Text('Guardar datos'),
    );
  }

  //Metodo capturar foto
  _tomarFoto(ImageSource source) async {
    final picker = new ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      print('No hay foto');
    } else {
      print('El path de la Foto es ${pickedFile.path}');
      setState(() {
        this._imagen = File(pickedFile.path);
        this._rutaImagen = pickedFile.path;
      });
    }
  }
}
