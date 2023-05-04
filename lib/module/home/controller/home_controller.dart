import 'package:flutter/material.dart';
import 'package:pos_app_skripsi/state_util.dart';
import '../view/home_view.dart';

class MainNavigationController extends State<MainNavigationView> implements MvcController {
  static late MainNavigationController instance;
  late MainNavigationView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int selectedIndex = 0;
}

