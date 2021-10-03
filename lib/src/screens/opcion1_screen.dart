import 'package:flutter/material.dart';

class Opcion1Screen extends StatefulWidget {
  Opcion1Screen({Key? key}) : super(key: key);

  @override
  _Opcion1ScreenState createState() => _Opcion1ScreenState();
}

class _Opcion1ScreenState extends State<Opcion1Screen> {
  //Agrego mis variables a utilizar
  TextEditingController txtMontoPagar = TextEditingController();
  var calcPropina;
  var montoTotal;

  @override
  Widget build(BuildContext context) {
    TextFormField txtMonto = TextFormField(
      controller: txtMontoPagar,
      decoration: InputDecoration(
        hintText: 'Introduce el monto a pagar',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)
      ),
    );

    //Agrego boton dentro de mi build
    ElevatedButton btnCalcular = ElevatedButton(
      onPressed: () {
        //Validaciones
        if (txtMontoPagar.text.isEmpty ) {
          showDialog <String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Cuenta'),
              content: Text('El monto total a pagar no es valido'),
            )
          ); 
        } else {
          var cantidadInt    = double.parse(txtMontoPagar.text); //Valor antes propina

          if(cantidadInt <= 0){
            showDialog <String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Cuenta'),
              content: Text('El monto total a pagar no es valido'),
            )
          ); 

          } else{
            //Operaciones
            double calcPropina = cantidadInt * .10; //Calculo propina
            double montoTotal  = cantidadInt + calcPropina; //Suma del monto total a pagar

            showDialog <String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Cuenta'),
                content: Text('El monto total a pagar es: $montoTotal'),
              )
            );
          }
        }
       
      },
      child: const Text ('Calcular monto'),
    );
    
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: Colors.blue[100],
        ),
        Card(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 500),
          color: Colors.blue[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                txtMonto,
                SizedBox(height: 5,),
                btnCalcular,
              ],
            ),
          )
        ),
      ],
    );
  }
}
