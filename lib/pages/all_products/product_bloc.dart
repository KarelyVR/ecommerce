import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

// Eventos
abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

// Estados
abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadSuccessState extends ProductState {
  final List<Product> products;

  ProductLoadSuccessState(this.products);
}

class ProductLoadFailureState extends ProductState {}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductsEvent) {
      yield ProductInitialState();
      try {
        final products = await fetchProducts();
        yield ProductLoadSuccessState(products);
      } catch (_) {
        yield ProductLoadFailureState();
      }
    }
  }

  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Product> products = await compute(parseProducts, data);
      return products;
    } else {
      throw Exception('Error al cargar los productos');
    }
  }
}

List<Product> parseProducts(List<dynamic> data) {
  return data.map((json) => Product.fromJson(json)).toList();
}
