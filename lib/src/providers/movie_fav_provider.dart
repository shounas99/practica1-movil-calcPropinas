import 'package:flutter/material.dart';

class MovieFavProvider extends ChangeNotifier{
  bool favorite = false;

  bool get getFavoriteMovie => favorite;

  set setFavorite(bool value){
    this.favorite = value;
    notifyListeners();
  }

  set setNoFavorite( bool value){
    this.favorite = value;
  }

}