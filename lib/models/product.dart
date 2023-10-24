class Producto {
  final int id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String image;
  int quantity;

  Producto({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
    required this.quantity,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      name: json['title'],
      category: json['category'],
      price: json['price'].toDouble(),
      description: json['description'],
      image: json['image'],
      quantity: 1,
    );
  }
}