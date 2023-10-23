import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'electronics.dart';

// Eventos
abstract class ElectronicsEvent {}

class FetchElectronicsEvent extends ElectronicsEvent {}

// Estados
abstract class ElectronicsState {}

class ElectronicsInitialState extends ElectronicsState {}

class ElectronicsLoadSuccessState extends ElectronicsState {
  final List<Electronics> electronics;

  ElectronicsLoadSuccessState(this.electronics);
}

class ElectronicsLoadFailureState extends ElectronicsState {}

class ElectronicsBloc extends Bloc<ElectronicsEvent, ElectronicsState> {
  ElectronicsBloc() : super(ElectronicsInitialState());

  @override
  Stream<ElectronicsState> mapEventToState(ElectronicsEvent event) async* {
    if (event is FetchElectronicsEvent) {
      yield ElectronicsInitialState();
      try {
        final electronics = await fetchElectronics();
        yield ElectronicsLoadSuccessState(electronics);
      } catch (_) {
        yield ElectronicsLoadFailureState();
      }
    }
  }

  Future<List<Electronics>> fetchElectronics() async {
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/category/electronics'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Electronics> electronics =
          await compute(parseElectronics, data);
      return electronics;
    } else {
      throw Exception('Error al cargar los productos');
    }
  }
}

List<Electronics> parseElectronics(List<dynamic> data) {
  return data.map((json) => Electronics.fromJson(json)).toList();
}
