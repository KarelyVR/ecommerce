import 'product.dart';

class MyProducts {
  static List<Producto> allProducts = [
    Producto(
        id: 1,
        name: 'Nike Air Max',
        category: "20%",
        price: 180.00,
        description: 'description',
        image: 'assets/nike1.jpg',
        quantity: 1),
    Producto(
        id: 1,
        name: 'Anillo',
        category: "10%",
        price: 1120.00,
        description: 'description',
        image: 'assets/joyeria1.jpg',
        quantity: 1),
    Producto(
        id: 1,
        name: 'Teclado',
        category: "5%",
        price: 450.00,
        description: 'description',
        image: 'assets/electronica2.jpg',
        quantity: 1),
    Producto(
        id: 1,
        name: 'Nike Originals',
        category: "30%",
        price: 120.00,
        description: 'description',
        image: 'assets/nike3.jpg',
        quantity: 1),
    Producto(
        id: 1,
        name: 'Collar',
        category: "15%",
        price: 1600.00,
        description: 'description',
        image: 'assets/joyeria2.jpg',
        quantity: 1),
    Producto(
        id: 1,
        name: 'Monitor',
        category: "25%",
        price: 600.00,
        description: 'description',
        image: 'assets/electronica1.jpg',
        quantity: 1),
  ];

  static List<Producto> joyeriaList = [
    Producto(
        id: 1,
        name: 'Vestido azul',
        category: "Disponible",
        price: 180.00,
        description: 'description',
        image: 'assets/nike1.jpg',
        quantity: 1),
    Producto(
        id: 1,
        name: 'Vestido rojo',
        category: "Disponible",
        price: 120.00,
        description: 'description',
        image: 'assets/nike3.jpg',
        quantity: 1)
  ];
  static List<Producto> electronicaList = [
    Producto(
        id: 1,
        name: 'Vestido azul',
        category: "Disponible",
        price: 180.00,
        description: 'description',
        image: 'assets/nike1.jpg',
        quantity: 1),
    Producto(
        id: 1,
        name: 'Vestido rojo',
        category: "Disponible",
        price: 120.00,
        description: 'description',
        image: 'assets/nike3.jpg',
        quantity: 1)
  ];
}
