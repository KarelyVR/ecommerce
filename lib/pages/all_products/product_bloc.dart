import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product.dart';

// Eventos
abstract class ProductEvent {}

class FetchProductsEvent extends ProductEvent {}

class AddToCartEvent extends ProductEvent {
  final int productId;

  AddToCartEvent(this.productId);
}

class RemoveFromCartEvent extends ProductEvent {
  final int productId;

  RemoveFromCartEvent(this.productId);
}

// Estados
abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadSuccessState extends ProductState {
  final List<Product> products;

  ProductLoadSuccessState(this.products);
}

class ProductLoadFailureState extends ProductState {}

class CartUpdatedState extends ProductState {
  final List<CartItemProduct> cartItems;

  CartUpdatedState(this.cartItems);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<CartItem> cart = []; // Lista de elementos en el carrito
  List<Product> products = []; // Lista de productos

  ProductBloc() : super(ProductInitialState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductsEvent) {
      yield ProductInitialState();
      try {
        final products = await fetchProducts();
        this.products = products;
        yield ProductLoadSuccessState(products);
      } catch (_) {
        yield ProductLoadFailureState();
      }
    } else if (event is AddToCartEvent) {
      final productId = event.productId;
      final existingItem = cart.firstWhere(
        (item) => item.productId == productId,
        orElse: () => CartItem(productId: productId, quantity: 0),
      );

      if (existingItem.quantity == 0) {
        cart.add(existingItem);
      }

      existingItem.quantity++;

      final cartItems = cart.map((item) {
        final product = products.firstWhere((p) => p.id == item.productId);
        return CartItemProduct(product: product, quantity: item.quantity);
      }).toList();

      yield CartUpdatedState(cartItems);
    } else if (event is RemoveFromCartEvent) {
      final productId = event.productId;
      final existingItem = cart.firstWhere(
        (item) => item.productId == productId,
        orElse: () => CartItem(productId: productId, quantity: 0),
      );

      if (existingItem.quantity > 0) {
        existingItem.quantity--;

        if (existingItem.quantity == 0) {
          cart.remove(existingItem);
        }

        final cartItems = cart.map((item) {
          final product = products.firstWhere((p) => p.id == item.productId);
          return CartItemProduct(product: product, quantity: item.quantity);
        }).toList();

        yield CartUpdatedState(cartItems);
      }
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

List<Product> parseProducts(List<dynamic> data) {
  return data.map((json) => Product.fromJson(json)).toList();
}
