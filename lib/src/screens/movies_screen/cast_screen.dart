// //Nuevo widget que hicimos, NOTA: AUN NO FUNCIONA lo comento

// import 'package:flutter/material.dart';
// import 'package:practica2/src/models/cast_movies_model.dart';
// import 'package:practica2/src/network/api_cast.dart';

// class CastingCards extends StatefulWidget {
//   CastingCards({Key? key}) : super(key: key);

//   @override
//   _CastingCardsState createState() => _CastingCardsState();
// }

//   ApiCast? apiCast;

// class _CastingCardsState extends State<CastingCards> {
//   @override

//   @override
//   void initState() {
//     super.initState();
//     apiCast = ApiCast();
    
//   }

//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: apiCast!.getAllCast(),
//       builder: (BuildContext context, AsyncSnapshot<List<CastMoviesModel>?> snapshot){
//         if( snapshot.hasError){
//           return Center(
//             child: Text('Hay un error en la peticion de actores2'),
//           );
//         } else{
//           if(snapshot.connectionState == ConnectionState.done){
//             return listCastMovies(snapshot.data);
//           }else{
//             return CircularProgressIndicator();
//           }
//         }
//       }

//     );
//   }


//   //Widget de lista de actores
//   Widget listCastMovies(List<CastMoviesModel>? moviesCast){
//     return ListView.separated(
//       itemBuilder: (context, index){
//         CastMoviesModel cast = moviesCast![index];
//         return Text(cast.name!); //CardCastView

//       },
//       separatorBuilder: ( _, __) => Divider(height: 10,),
//       itemCount: moviesCast!.length
//     );
//   }

  
// }