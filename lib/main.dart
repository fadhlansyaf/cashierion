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

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> writeCounter(List<int> bytes, String name) async {
    final path = await _localPath;
    // Create a file for the path of
    // device and file name with extension

    File file = File('$path/$name');
    print("Save file");

    // Write the data in the file you have created
    return file.writeAsBytes(bytes);
  }
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