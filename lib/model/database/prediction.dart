import 'package:intl/intl.dart';
import 'package:cashierion/utils/constant.dart';

class PredictionModel {
  final int item;
  final double sales;
  final String dates;
  final DateTime dateTime;

  PredictionModel(
      {required this.item, required this.sales, required this.dates}) : dateTime = DateTime.parse(dates);

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
          item: json["item"] ?? 0,
          sales: json["sales"] ?? 0,
          dates: json["dates"] ??
              DateFormat(DateTimeFormat.standard).format(DateTime.now()));

  Map<String, dynamic> toJson() => {
    "item": item,
    "sales": sales,
    "dates": dates.split(' ').first
  };
}
