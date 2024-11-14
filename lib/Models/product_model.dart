class Product {
  final String productId;
  final String productName;
  final double price;
  final double taxPercentage;

  Product({
    required this.productId,
    required this.productName,
    required this.price,
    required this.taxPercentage,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      productId: id,
      productName: map['product_name'] ?? 'No name',
      price: map['price']?.toDouble() ?? 0.0,
      taxPercentage: map['tax_percentage']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_name': productName,
      'price': price,
      'tax_percentage': taxPercentage,
    };
  }
}
