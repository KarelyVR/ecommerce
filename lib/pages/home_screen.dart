import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/pages/details_screen.dart';
import 'package:ecommerce/pages/electronics_productos/main_electronics.dart';
import 'package:ecommerce/pages/joyeria_productos/main_jewelry.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Producto> fakeStoreProducts = [];
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    loadFakeStoreProducts();
  }

  Future<void> loadFakeStoreProducts() async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(_loadProductsIsolate, receivePort.sendPort);
    final completer = Completer<List<Producto>>();

    receivePort.listen((message) {
      if (message is List<Producto>) {
        completer.complete(message);
      } else if (message is String) {
        completer.completeError(message);
      }
      receivePort.close();
      isolate.kill();
    });

    completer.future.then((products) {
      setState(() {
        fakeStoreProducts = products;
      });
    }).catchError((error) {
      print(error);
    });
  }

  static void _loadProductsIsolate(SendPort sendPort) async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((json) => Producto.fromJson(json)).toList();
        sendPort.send(products);
      } else {
        sendPort.send('Error en la carga de datos');
      }
    } catch (e) {
      sendPort.send('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fakeStoreProducts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Productos",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProductCategory(index: 0, name: "Todo"),
                      _buildProductCategory(index: 1, name: "Joyeria"),
                      _buildProductCategory(index: 2, name: "Electronica")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: isSelected == 0
                        ? _buildAllProducts()
                        : isSelected == 1
                            ? const Joyeria()
                            : const Electronics(),
                  ),
                ],
              ),
            ),
    );
  }

  _buildProductCategory({required int index, required String name}) =>
      GestureDetector(
        onTap: () {
          setState(() {
            isSelected = index;
          });
        },
        child: Container(
          width: 100,
          height: 40,
          margin: const EdgeInsets.only(top: 10, right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected == index ? Colors.red : Colors.red.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

  _buildAllProducts() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        scrollDirection: Axis.vertical,
        itemCount: fakeStoreProducts.length,
        itemBuilder: (context, index) {
          final product = fakeStoreProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(product: product),
                ),
              );
            },
            child: ProductCard(product: product),
          );
        },
      );
}
