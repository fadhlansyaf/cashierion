import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cashierion/core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cashierion/theme/theme_constants.dart';
import 'package:cashierion/theme/theme_manager.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:open_file/open_file.dart';
import 'package:cashierion/module/home/controller/home_binding.dart';

import 'module/register/controller/register_binding.dart';
import 'module/register/view/register_page.dart';
import 'utils/preferences.dart';

ThemeManager _themeManager = ThemeManager();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.getInstance().init();
  var haveAccount = Preferences.getInstance().getString(SharedPreferenceKey.STORE_NAME) != null;
  runApp(DismissKeyboard(
    child: GetMaterialApp(
      title: 'POS',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: haveAccount ? const HomePage() : const RegisterPage(),
      initialBinding: haveAccount ? HomeBinding() : RegisterBinding(),
      ),
  ));
}


class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}