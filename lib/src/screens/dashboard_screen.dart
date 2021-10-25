import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_setting.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Cristina Aguilar Rodriguez'),
              accountEmail: Text('17030674@itcelaya.edu.mx'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://e7.pngegg.com/pngimages/193/660/png-clipart-computer-icons-woman-avatar-avatar-girl-black-hair-logo.png'),
                child: Icon(Icons.verified_user),
              ),
              decoration: BoxDecoration(color: ColorSettings.colorPrimary),
            ),
            ListTile(
              title: Text('Perfil'),
              subtitle: Text('Perfil de usuario'),
              leading: Icon(Icons.face),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: Text('Propinas'),
              subtitle: Text('Se calcula el total a pagar'),
              leading: Icon(Icons.monetization_on),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/opc1');
              },
            ),
            ListTile(
              title: Text('Intenciones'),
              subtitle: Text('Intenciones implicitas'),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/intenciones');
              },
            ),
            ListTile(
              title: Text('Notas'),
              subtitle: Text('CRUD Notas'),
              leading: Icon(Icons.notes),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/notas');
              },
            ),
            ListTile(
              title: Text('Movies'),
              subtitle: Text('Prueba API REST'),
              leading: Icon(Icons.movie),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/movie');
              },
            ),
          ],
        ),
      ),
    );
  }
}
