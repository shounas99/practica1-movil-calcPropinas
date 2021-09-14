import 'package:flutter/material.dart';
import 'package:practica2/src/screens/dashboard_screen.dart';
import 'package:practica2/src/utils/color_setting.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var isLoading = false;
  TextEditingController txtEmailCont = TextEditingController();
  TextEditingController txtPwdCont   = TextEditingController();

  @override
  Widget build(BuildContext context) {
  TextFormField txtEmail = TextFormField(
    controller: txtEmailCont,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: 'Introduce tu correo electrónico',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
    ),
  );
  

   TextFormField txtPwd = TextFormField(
    controller: txtPwdCont,
    keyboardType: TextInputType.visiblePassword,
    maxLength: 5,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Introduce tu contraseña',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
    ),
  );

    //Lo puse dentro del build porque si se hace un cambio debe de estar aqui
     ElevatedButton btnLogin = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorSettings.colorButton
      ),
      onPressed: (){ 
        print(txtEmailCont.text);
        isLoading = true;
        setState(() {});
          Future.delayed(Duration(seconds: 15),(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen())
            );
          });
        
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.login),
          Text('Validar Usuario')
        ],
      )
    );

    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo_merli.jpg'),
                fit: BoxFit.fill
              )
            ),
          ),
          //LayoutBuilder(builder: (BuildContext contexr, BoxConstraints constraints){
          //  return SingleChildScrollView(
          //    child: 
              Card(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    txtEmail,
                    SizedBox(height: 5,),
                    txtPwd,
                    btnLogin
                  ],
                ),
              )
            ),
          //  );
          //}
          //),
          Positioned(
            child: Image.asset('assets/logo_itc.png', width: 150,),
            top: 120,
          ),
          Positioned(
            child: isLoading == true ?  CircularProgressIndicator() : Container(),
            top: 350
          )
        ],
      
      );
    }
  }