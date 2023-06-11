import 'package:intl/intl.dart';
import 'package:pos_app_skripsi/utils/constant.dart';

class TransactionModel {
  final int id;
  final int paymentTypeId;
  final int? paymentDetailId;
  final String invoice;
  final String dates;
  final double sales;

  TransactionModel(
      {this.id = 0,
      required this.paymentTypeId,
      this.paymentDetailId,
      required this.invoice,
      required this.dates,
      required this.sales});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          id: json["transaction_id"] ?? 0,
          paymentTypeId: json["payment_type_id"] ?? 0,
          paymentDetailId: json["payment_detail_id"],
          invoice: json["invoice"] ?? '',
          dates: json["dates"] ?? DateFormat(DateTimeFormat.standard).format(DateTime.now()),
          sales: json["sales"] ?? 0);

  Map<String, dynamic> toJson() => {
    "payment_type_id": paymentTypeId,
    "payment_detail_id": paymentDetailId,
    "invoice": invoice,
    "dates": dates,
    "sales": sales
  };

  TransactionModel copyWith({
    int? id,
    int? paymentTypeId,
    int? paymentDetailId,
    String? invoice,
    String? dates,
    double? sales,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      paymentTypeId: paymentTypeId ?? this.paymentTypeId,
      paymentDetailId: paymentDetailId ?? this.paymentDetailId,
      invoice: invoice ?? this.invoice,
      dates: dates ?? this.dates,
      sales: sales ?? this.sales,
    );
  }
}
