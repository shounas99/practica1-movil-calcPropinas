import 'package:flutter/material.dart';

import 'package:practica2/src/models/profile_model.dart';
import 'package:practica2/src/screens/agregar_profile_screen.dart';

import 'package:practica2/src/database/database_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late DatabaseProfile _databaseProfile;

  //initState -> implementar metodos, antes de que se muestre la interfaz
  @override
  void initState() {
    super.initState();
    _databaseProfile = DatabaseProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil usuario'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/agregarProfile');
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: FutureBuilder(
        future: _databaseProfile.getAllProfiles(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProfileModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ocurrido un error en la petición'),
            );
          } else {
            //Ya termino de procesar mis datos
            if (snapshot.connectionState == ConnectionState.done) {
              return _listasProfiles(snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  //Mi perfil
  Widget _listasProfiles(List<ProfileModel> profiles) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(milliseconds: 500), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          ProfileModel profile = profiles[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Ruta avatar: ${profile.foto}'),
                ),
                Divider(),
                ListTile(
                  title: Text('Nombre: ${profile.nombre}'),
                ),
                Divider(),
                ListTile(
                  title: Text('Apellido Paterno: ${profile.apaterno}'),
                ),
                Divider(),
                ListTile(
                  title: Text('Apellido Materno: ${profile.amaterno}'),
                ),
                Divider(),
                ListTile(
                  title: Text('Número de Teléfono: ${profile.telefono}'),
                ),
                Divider(),
                ListTile(
                  title: Text('Correo electrónico: ${profile.correo}'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      //Hare llamado a mi objeto para poder editarlo
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgregarProfileScreen(
                                      profile:
                                          profile, //A mi parametro profile, le mando lo que tenga en mi obj profile
                                    )));
                      },
                      icon: Icon(Icons.edit),
                      iconSize: 18,
                    ),
                    //Eliminar
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmación'),
                                content: Text('¿Estas seguro de borrar?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _databaseProfile
                                            .delete(profile.id!)
                                            .then((noRows) {
                                          if (noRows > 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Se ha eliminado')));
                                            setState(() {});
                                          }
                                        });
                                      },
                                      child: Text('Si')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No')),
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.delete),
                      iconSize: 18,
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: profiles.length, //La propiedad no encontro valores
      ),
    );
  }
}
