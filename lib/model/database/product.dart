import 'package:get/get.dart';

class ProductModel {
  final int id;
  final int? productCategoryId;
  final String name;
  final String image;
  final double price;
  final double sellingPrice;
  final int stock;
  final String description;
  /// Quantity hanya digunakan ketika transaction
  Rx<int> quantity = 0.obs;

  ProductModel(
      {required this.name,
      this.productCategoryId = 0, this.id = 0,
      this.image = '',
      required this.price,
      required this.description,
      required this.sellingPrice,
      required this.stock,});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      name: json["name"] ?? '',
      price: json["price"] ?? 0,
      description: json["description"] ?? '',
      sellingPrice: json["selling_price"] ?? 0,
      stock: json["stock"] ?? '',
      productCategoryId: json["product_category_id"] ?? 0,
      image: json["image"] ?? '', id: json["product_id"] ?? 0);

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "selling_price": sellingPrice,
        "stock": stock,
        "image": image,
        "product_category_id": productCategoryId ?? 0
      };
}
