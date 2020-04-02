import 'package:flutter/material.dart';
import 'package:kronogram/pages/root_page.dart';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/authentication.dart';

void main() => runApp(KronogramApp());

class KronogramApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: new RootPage());
  }
}
