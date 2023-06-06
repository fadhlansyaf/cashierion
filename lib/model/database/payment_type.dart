class PaymentTypeModel {
  final int id;
  final String paymentName;

  PaymentTypeModel({required this.id, required this.paymentName});

  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) =>
      PaymentTypeModel(
          id: json["payment_type_id"] ?? 0,
          paymentName: json["payment_name"] ?? '');

  Map<String, dynamic> toJson() => {
    "payment_name": paymentName
  };
}
