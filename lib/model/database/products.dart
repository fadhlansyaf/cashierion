class Products {
  final int productCategoryId;
  final String name;
  final String image;
  final double price;
  final double sellingPrice;
  final int stock;
  final String description;

  Products(
      {required this.name,
      this.productCategoryId = 0,
      required this.image,
      required this.price,
      required this.description,
      required this.sellingPrice,
      required this.stock});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
      name: json["name"] ?? '',
      price: json["price"] ?? 0,
      description: json["description"] ?? '',
      sellingPrice: json["selling_price"] ?? 0,
      stock: json["stock"] ?? '',
      productCategoryId: json["product_category_id"] ?? 0,
      image: json["image"] ?? '');

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "selling_price": sellingPrice,
        "stock": stock,
        "image": image
      };
}
