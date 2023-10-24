import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/pages/all_products/product_bloc.dart';


class ECommerceGallery extends StatelessWidget {
  const ECommerceGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los productos'),
      ),
      body: BlocProvider(
        create: (context) => ProductBloc()..add(FetchProductsEvent()),
        child: const ProductList(),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

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
              );
            },
          );
        } else {
          return const Center(child: Text('Error al cargar los productos'));
        }
      },
    );
  }
}
