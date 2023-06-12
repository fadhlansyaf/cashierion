class ReportProductModel {
  final int productId;
  final String name;
  final int totalQuantity;
  final double productPrice;
  final double productSellingPrice;

  ReportProductModel(
      {required this.productId,
      required this.name,
      required this.totalQuantity,
        required this.productSellingPrice,
      required this.productPrice});

  factory ReportProductModel.fromJson(Map<String, dynamic> json) =>
      ReportProductModel(
          productId: json["product_id"] ?? 0,
          name: json["name"] ?? '',
          productPrice: json["price"] ?? 0,
          productSellingPrice: json["selling_price"] ?? 0,
          totalQuantity: json["totalQuantity"] ?? 0);
}
