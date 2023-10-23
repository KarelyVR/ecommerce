class Electronics {
  final int id;
  final String title;
  final double price;
  final String image;

  Electronics({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory Electronics.fromJson(Map<String, dynamic> json) {
    return Electronics(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
