import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/pages/all_products/product_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProductBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de compras'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is CartUpdatedState) {
            final cartItems = state.cartItems;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ListTile(
                  title: Text(cartItem.product.title),
                  subtitle: Text("Cantidad: ${cartItem.quantity}"),
                  leading: Image.network(cartItem.product.image),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          bloc.add(RemoveFromCartEvent(cartItem.product.id));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          bloc.add(AddToCartEvent(cartItem.product.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('El carrito está vacío'));
          }
        },
      ),
    );
  }
}
