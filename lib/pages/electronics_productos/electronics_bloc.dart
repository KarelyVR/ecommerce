// ignore_for_file: unused_import

import 'dart:isolate';
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
  final List<Electronicos> electronics;

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
        final electronics = await fetchElectronicsUsingIsolate();
        yield ElectronicsLoadSuccessState(electronics);
      } catch (_) {
        yield ElectronicsLoadFailureState();
      }
    }
  }

  Future<List<Electronicos>> fetchElectronicsUsingIsolate() async {
    final response = await _fetchElectronicsInIsolate();
    return response;
  }

  // Future<List<Electronicos>> _fetchElectronicsInIsolate() async {
  //   final receivePort = ReceivePort();
  //   await Isolate.spawn(_isolateFunction, receivePort.sendPort);

  //   final completer = Completer<List<Electronicos>>();
  //   receivePort.listen((data) {
  //     if (data is List<Electronicos>) {
  //       completer.complete(data);
  //     } else {
  //       completer.completeError('Error al cargar los productos');
  //     }
  //   });

  //   return completer.future;
  // }

  Future<List<Electronicos>> _fetchElectronicsInIsolate() async {
  try {
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/category/electronics'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Electronicos> electronics = await compute(parseElectronics, data);
      return electronics;
    } else {
      throw Exception('Error en la respuesta del servidor: ${response.statusCode}');
    }
  } catch (e) {
    print('Excepción al cargar productos electrónicos: $e');
    throw Exception('Error al cargar productos electrónicos');
  }
}


  static void _isolateFunction(SendPort sendPort) async {
    final sendReceivePort = ReceivePort();
    sendPort.send(sendReceivePort.sendPort);

    sendReceivePort.listen((message) async {
      if (message is SendPort) {
        try {
          final electronics = await fetchElectronics();
          message.send(electronics);
        } catch (error) {
          message.send('Error al cargar los productos');
        }
      }
    });
  }

  static Future<List<Electronicos>> fetchElectronics() async {
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/category/electronics'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Electronicos> electronics = parseElectronics(data);
      return electronics;
    } else {
      throw Exception('Error al cargar los productos');
    }
  }

  static List<Electronicos> parseElectronics(List<dynamic> data) {
    return data.map((json) => Electronicos.fromJson(json)).toList();
  }
}
