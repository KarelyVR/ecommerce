import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/pages/all_products/product_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ECommerceGallery(),
    );
  }
}

class ECommerceGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los productos'),
      ),
      body: BlocProvider(
        create: (context) => ProductBloc()..add(FetchProductsEvent()),
        child: ProductList(),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoadSuccessState) {
          final products = state.products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                leading: Image.network(product.image),
                trailing: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(AddToCartEvent(product.id));
                  },
                  child: Text('Agregar al carrito'),
                ),
              );
            },
          );
        } else if (state is CartUpdatedState) {
          // Render the cart items here, for example:
          final cartItems = state.cartItems;
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return ListTile(
                title: Text(cartItem.product.title),
                subtitle: Text("Cantidad: ${cartItem.quantity}"),
                leading: Image.network(cartItem.product.image),
              );
            },
          );
        }

        // Si ninguno de los casos anteriores se cumple, devuelve un widget vacío
        return Container();
      },
    );
  }
}
