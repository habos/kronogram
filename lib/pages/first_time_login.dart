import 'package:flutter/material.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'dart:core';
import 'dart:developer';


class IntroPage extends StatefulWidget {
  IntroPage({Key key, this.auth, this.userId})
      : super(key: key);

  final BaseAuth auth;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {


  //Facebook Login

  bool _isLoggedInFacebook = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async{


    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedInFacebook = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedInFacebook = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedInFacebook = false );
        break;
    }

  }

  _FacebookLogout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedInFacebook = false;
    });
  }

  Widget FacebookButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: _isLoggedInFacebook
            ? SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text("Logout of Facebook",
              style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              _FacebookLogout();
            },
          ),
        )
        : SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text("Login with Facebook",
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              _loginWithFB();
            },
          ),
        ));
  }



  //Twitter Login

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: 'JZScfVJ2TnkzVHy7lS7XHGU1z',
    consumerSecret: 'fk9BSlBe6mDnioJeoIc7thAQeODgnbEBZAJoBsuPVGYG8PmMQW',
  );

  bool _isLoggedInTwitter = false;

  void _loginTwitter() async {
    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        log("Twitter Login Success");
        setState(() => _isLoggedInTwitter = true );
        break;
      case TwitterLoginStatus.cancelledByUser:
        log('Login cancelled by user.');
        setState(() => _isLoggedInTwitter = false );
        break;
      case TwitterLoginStatus.error:
        log('Login error: ${result.errorMessage}');
        setState(() => _isLoggedInTwitter = false );
        break;
    }
  }

  void _logoutTwitter() async {
    await twitterLogin.logOut();

    setState(() {
      _isLoggedInTwitter = false;
    });
  }

  Widget twitterButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: _isLoggedInTwitter
            ? SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text("Logout of Twitter",
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              _logoutTwitter();
            },
          ),
        )
            : SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text("Login with Twitter",
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              _loginTwitter();
            },
          ),
        ));
  }

  //Build Components
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body:
            new Container(
                padding: EdgeInsets.all(16.0),
                child: new Form(
                  child: new ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      FacebookButton(),
                      twitterButton(),
                    ],
                  ),
                ))
        )
      );
  }
}