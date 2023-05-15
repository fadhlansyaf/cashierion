class ProductsModel {
  final String name;
  final double price;
  final double sellingPrice;
  final int stock;
  final String description;

  ProductsModel({
    required this.name,
    required this.price,
    required this.description,
    required this.sellingPrice,
    required this.stock
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    name: json["name"],
    price: json["price"],
    description: json["desc"], sellingPrice: json["selling_price"], stock: json["stock"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "description": description,
    "selling_price" : sellingPrice,
    "stock": stock
  };
}