import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/utils/color_setting.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intenciones implicitas'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lightGreenAccent[100],
              title: Text('Abrir pagina web'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('https://celaya.tecnm.mx/'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _abrirWeb,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lightGreenAccent[100],
              title: Text('Llamada telefonica'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Cel: 4613299321'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _llamadaTelefonica,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lightGreenAccent[100],
              title: Text('Enviar SMS'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Cel: 4613299321'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarSMS,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.lightGreenAccent[100],
              title: Text('Enviar Email'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('To: 17030674@itcelaya.edu.mx'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarEmail,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
                tileColor: Colors.lightGreenAccent[100],
                title: Text('Tomar foto'),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.touch_app_rounded,
                      size: 18.0,
                      color: Colors.red,
                    ),
                    Text('Smile c:'),
                  ],
                ),
                leading: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 1.0))),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: _tomarFoto),
          ),
        ],
      ),
    );
  }

  _abrirWeb() async {
    const url = "https://celaya.tecnm.mx/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _llamadaTelefonica() async {
    const url = "tel: 4613299321";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarSMS() async {
    const url = "sms: 4613299321";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarEmail() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: '17030674@itcelaya.edu.mx',
        query: 'subject=Saludo&body=Bienvenido c:');

    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    }
  }

  _tomarFoto() async {
    final picker = new ImagePicker();
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile == null) {
      print('No hay foto');
    } else {
      print('El path de la Foto es ${pickedFile.path}');
    }
  }
}
