class Product {
  final String id;
  final String name;
  final String image;
  final String url;
  final double currentPrice;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.url,
    required this.currentPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      url: json['url'] ?? '',
      currentPrice: (json['currentPrice'] ?? 0).toDouble(),
    );
  }
}
