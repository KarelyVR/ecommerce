class Jewelry {
  final int id;
  final String title;
  final double price;
  final String image;

  Jewelry({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory Jewelry.fromJson(Map<String, dynamic> json) {
    return Jewelry(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
