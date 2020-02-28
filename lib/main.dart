import 'package:flutter/material.dart';
import 'package:kronogram/pages/root_page.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/services/database.dart';

void main() => runApp(new KronogramApp());

class KronogramApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Login',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth(), db: new Database()));
  }
}

//import 'package:flutter/material.dart';
//import 'package:kronogram/UI_pages/login_page_widget/login_page_widget.dart';
//
//void main() => runApp(KronogramApp());
//
//class KronogramApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: LoginPageWidget(),
//    );
//  }
//}
