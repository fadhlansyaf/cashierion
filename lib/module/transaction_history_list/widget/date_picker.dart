import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cashierion/core.dart';
import 'package:cashierion/utils/constant.dart';

/// Flutter code sample for [showDatePicker].

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, this.restorationId, required this.startDate, required this.endDate, required this.controller});
  final Rx<DateTime> startDate;
  final Rx<DateTime> endDate;
  final TransactionHistoryListLogic controller;

  final String? restorationId;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerState extends State<DatePicker> with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  late final RestorableDateTimeN _startDate =
      RestorableDateTimeN(widget.startDate.value);
  late final RestorableDateTimeN _endDate =
      RestorableDateTimeN(widget.endDate.value);
  late final RestorableRouteFuture<DateTimeRange?>
      _restorableDateRangePickerRouteFuture =
      RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });
    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        widget.startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;
        widget.endDate.value = newSelectedDate.end;
        widget.controller.onInit();
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  @pragma('vm:entry-point')
  static Route<DateTimeRange?> _dateRangePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        var now = DateTime.now();
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
              _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime(now.year - 10),
          currentDate: DateTime.now(),
          lastDate: DateTime(now.year + 10),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _restorableDateRangePickerRouteFuture.present();
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(minHeight: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              FittedBox(
                child: Text(
                  "${DateFormat(DateTimeFormat.standardNoTime).format(widget.startDate.value)} - ${DateFormat(DateTimeFormat.standardNoTime).format(widget.endDate.value)}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
