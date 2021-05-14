import 'package:flutter/material.dart';
import 'package:test_data_base/controller/form_controller.dart';
import 'package:test_data_base/model/form.dart';
import 'package:test_data_base/page/create_item_page.dart';
import 'package:test_data_base/page/create_item_page_web.dart';
import 'package:test_data_base/page/database_page.dart';
import 'package:test_data_base/page/database_page_web.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red[900],
        title: Text('Admin panel'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: CreateItemPageWeb(title: 'create',)),
          Expanded(child: DatabasePageWeb(title: 'database',)),
        ],
      ),
    );
  }
}
