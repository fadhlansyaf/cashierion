class TransactionModel {
  final int id;
  final int paymentTypeId;
  final int? paymentDetailId;
  final String invoice;
  final DateTime dates;
  final double sales;

  TransactionModel(
      {required this.id,
      required this.paymentTypeId,
      this.paymentDetailId,
      required this.invoice,
      required this.dates,
      required this.sales});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          id: json["id"] ?? 0,
          paymentTypeId: json["payment_type_id"] ?? 0,
          paymentDetailId: json["payment_detail_id"],
          invoice: json["invoice"] ?? '',
          dates: json["dates"] ?? DateTime.now(),
          sales: json["sales"] ?? 0);

  Map<String, dynamic> toJson() => {
    "payment_type_id": paymentTypeId,
    "payment_detail_id": paymentDetailId,
    "invoice": invoice,
    "dates": dates,
    "sales": sales
  };
}
