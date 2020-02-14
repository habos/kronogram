import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kronogram/pages/first_time_login.dart';
import 'package:kronogram/pages/login_signup_page.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/pages/home_page.dart';
import 'package:kronogram/services/database.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  FIRST_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth, this.db});

  final BaseAuth auth;
  final Database db;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  AuthResult result;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() async {
    var user = await widget.auth.getCurrentUser();
    _userId = user.uid.toString();
    var isNew = await widget.db.isNewUser(_userId);
    setState(() {
      print("This is the userID: " + _userId);
      print("Should say true:");
      print(isNew);
      if (isNew){
        authStatus = AuthStatus.FIRST_LOGGED_IN;
      } else {
        authStatus = AuthStatus.LOGGED_IN;
      }
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage(
          auth: widget.auth,
          db: widget.db,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.FIRST_LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new IntroPage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}