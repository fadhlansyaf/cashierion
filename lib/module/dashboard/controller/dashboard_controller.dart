import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/state_util.dart';
import '../view/dashboard_view.dart';

class DashboardController extends State<DashboardView> implements MvcController {
  static late DashboardController instance;
  late DashboardView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}