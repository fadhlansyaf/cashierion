class PaymentDetailModel {
  final int id;
  final int paymentTypeId;
  final String description;

  PaymentDetailModel(
      {this.id = 0,
      required this.paymentTypeId,
      required this.description});

  factory PaymentDetailModel.fromJson(Map<String, dynamic> json) =>
      PaymentDetailModel(
          id: json["payment_detail_id"] ?? 0,
          paymentTypeId: json["payment_type_id"] ?? 0,
          description: json["description"] ?? '');

  Map<String, dynamic> toJson() => {
    "payment_type_id": paymentTypeId,
    "description": description
  };
}
