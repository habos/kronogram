import 'package:flutter/material.dart';
import 'package:kronogram/services/authentication.dart';


class IntroPage extends StatefulWidget {
  IntroPage({Key key, this.auth, this.userId})
      : super(key: key);

  final BaseAuth auth;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter login demo"),
      ),
      body: new Container(
        child: new Text("Intro Page"),
      ),
    );
  }
}