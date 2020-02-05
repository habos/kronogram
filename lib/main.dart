import 'package:flutter/material.dart';
import 'package:kronogram/pages/root_page.dart';
import 'package:kronogram/services/authentication.dart';

void main() => runApp(new KronogramApp());

class KronogramApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()));
  }
}