import 'package:flutter/material.dart';
import 'package:practica2/src/providers/movie_fav_provider.dart';
import 'package:practica2/src/providers/movies_provider.dart';

import 'package:practica2/src/screens/agregar_nota_screen.dart';
import 'package:practica2/src/screens/agregar_profile_screen.dart';
import 'package:practica2/src/screens/intenciones_screen.dart';
import 'package:practica2/src/screens/movies_screen/detail_screen.dart';
import 'package:practica2/src/screens/movies_screen/movie_fav_screen.dart';
import 'package:practica2/src/screens/movies_screen/popular_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/widgets/trailer_card.dart';
import 'package:provider/provider.dart';

// import 'package:practica2/src/providers/movies_provider.dart';
// import 'package:provider/provider.dart';


void main() {
  runApp(MyApp()); //MyApp -> Ahora mando notificar a mi MyApp
}

//------Widget MyApp------
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //movie
    // final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider())
      ],
      child: MaterialApp(
        routes: {
          '/opc1': (BuildContext context) => Opcion1Screen(),
          '/intenciones': (BuildContext context) => IntencionesScreen(),
          '/notas': (BuildContext context) => NotasScreen(),
          '/agregar': (BuildContext context) => AgregarNotasScreen(),
          '/profile': (BuildContext context) => ProfileScreen(),
          '/agregarProfile': (BuildContext context) => AgregarProfileScreen(),
          '/movie': (BuildContext context) => PopularScreen(),
          '/detail': ( _ ) => ChangeNotifierProvider(
            create: ( _ ) => MovieFavProvider(),
            child: DetailScrenn(),

          ),
          '/moviefav': (BuildContext context) => MovieFavScreen(),
          // '/movieTrailer': (BuildContext context) => TrailerCard()
        },
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
