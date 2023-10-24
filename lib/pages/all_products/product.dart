class Product {
  final int id;
  final String title;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}

class CartItem {
  final int productId;
  int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });
}

class CartItemProduct {
  final Product product;
  final int quantity;

  CartItemProduct({
    required this.product,
    required this.quantity,
  });
}
