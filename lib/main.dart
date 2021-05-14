import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:test_data_base/page/admin_page.dart';
import 'package:test_data_base/page/database_page.dart';
import 'page/create_item_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: platformHomePage(),
    );
  }

  platformHomePage() {
    if (kIsWeb) {
      return AdminPage();
    } else if (Platform.isAndroid || Platform.isIOS) {
      return DatabaseMobileScreen();
    }
  }

}