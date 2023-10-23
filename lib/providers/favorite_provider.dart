import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class FavoriteProvider extends ChangeNotifier{
  final List<Producto> _favorites = [];
  List<Producto> get favorites => _favorites;

  void toggleFavorite(Producto producto){
    if (_favorites.contains(producto)){
      _favorites.remove(producto);
    }else{
      _favorites.add(producto);
    }
    notifyListeners();
  }
  bool isExist(Producto producto){
    final isExist = _favorites.contains(producto);
    return isExist;
  }

  static FavoriteProvider of(
    BuildContext context, {
      bool listen = true,
    }){
     return Provider.of<FavoriteProvider>(
      context,
      listen:listen,
     ); 
    }
}