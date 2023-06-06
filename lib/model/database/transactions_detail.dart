class TransactionDetailModel {
  final int transactionId;
  final int productId;
  final int quantity;
  final String description;

  TransactionDetailModel(
      {required this.transactionId,
      required this.productId,
      required this.quantity,
      required this.description});

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) =>
      TransactionDetailModel(
          transactionId: json["transaction_id"],
          productId: json["product_id"],
          quantity: json["quantity"] ?? 0,
          description: json["desc"] ?? '');

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "product_id": productId,
        "quantity": quantity,
        "description": description
      };
}
