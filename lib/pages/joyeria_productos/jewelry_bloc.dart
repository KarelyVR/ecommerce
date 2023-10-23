// jewelry_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'jewelry.dart';

// Eventos
abstract class JewelryEvent {}

class FetchJewelryEvent extends JewelryEvent {}

// Estados
abstract class JewelryState {}

class JewelryInitialState extends JewelryState {}

class JewelryLoadSuccessState extends JewelryState {
  final List<Jewelry> jewelry;

  JewelryLoadSuccessState(this.jewelry);
}

class JewelryLoadFailureState extends JewelryState {}

class JewelryBloc extends Bloc<JewelryEvent, JewelryState> {
  JewelryBloc() : super(JewelryInitialState());

  @override
  Stream<JewelryState> mapEventToState(JewelryEvent event) async* {
    if (event is FetchJewelryEvent) {
      yield JewelryInitialState();
      try {
        final jewelry = await fetchJewelry();
        yield JewelryLoadSuccessState(jewelry);
      } catch (_) {
        yield JewelryLoadFailureState();
      }
    }
  }

  Future<List<Jewelry>> fetchJewelry() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/jewelery'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Jewelry> jewelry = await compute(parseJewelry, data);
      return jewelry;
    } else {
      throw Exception('Error al cargar los productos');
    }
  }
}

List<Jewelry> parseJewelry(List<dynamic> data) {
  return data.map((json) => Jewelry.fromJson(json)).toList();
}
