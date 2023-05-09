class ProductFormModel {
  final String productName;
  final int price;
  final String desc;

  ProductFormModel({
    required this.productName,
    required this.price,
    required this.desc,
  });

  factory ProductFormModel.fromJson(Map<String, dynamic> json) => ProductFormModel(
    productName: json["productName"],
    price: json["price"],
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "productName": productName,
    "price": price,
    "desc": desc,
  };
}