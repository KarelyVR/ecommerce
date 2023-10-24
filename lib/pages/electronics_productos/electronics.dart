class Electronicos {
  final int id;
  final String title;
  final double price;
  final String image;

  Electronicos({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory Electronicos.fromJson(Map<String, dynamic> json) {
    return Electronicos(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
