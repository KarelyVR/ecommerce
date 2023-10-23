import 'package:ecommerce/models/my_product.dart';
import 'package:ecommerce/pages/all_products/main_products.dart';
import 'package:ecommerce/pages/details_screen.dart';
import 'package:ecommerce/pages/electronics_productos/main_electronics.dart';
import 'package:ecommerce/pages/joyeria_productos/main_jewelry.dart';
import 'package:ecommerce/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          const Text(
            "Productos en descuento",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: isSelected == 0
                ? _buildAllProducts()
                : isSelected == 1
                    ? _buildJoyeria()
                    : _buildElectronica(),
          ),
        ],
      ),
    );
  }

  _buildProductCategory({required int index, required String name}) =>
      GestureDetector(
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ECommerceGallery(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Joyeria()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Electronics()),
              );
            } else {
              setState(() {
                isSelected = index;
              });
            }
          },
          child: Container(
              width: 100,
              height: 40,
              margin: const EdgeInsets.only(top: 10, right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isSelected == index ? Colors.red : Colors.red.shade300,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                name,
                style: const TextStyle(color: Colors.white),
              )));
}

_buildAllProducts() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.allProducts.length,
      itemBuilder: ((context, index) {
        final allProducts = MyProducts.allProducts[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(product: allProducts),
            ),
          ),
          child: ProductCard(product: allProducts),
        );
      }),
    );
_buildJoyeria() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.joyeriaList.length,
      itemBuilder: (context, index) {
        final joyeriaList = MyProducts.joyeriaList[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(product: joyeriaList),
            ),
          ),
          child: ProductCard(product: joyeriaList),
        );
      },
    );
_buildElectronica() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProducts.electronicaList.length,
      itemBuilder: (context, index) {
        final electronicaList = MyProducts.electronicaList[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(product: electronicaList),
            ),
          ),
          child: ProductCard(product: electronicaList),
        );
      },
    );
