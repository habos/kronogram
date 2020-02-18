import 'package:flutter/material.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:kronogram/services/instagram_login.dart' as insta;
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'dart:core';
import 'dart:developer';

import 'package:kronogram/services/database.dart';


class IntroPage extends StatefulWidget {
  IntroPage({Key key, this.auth, this.userId, this.logoutCallback, this.db})
      : super(key: key);

  final BaseAuth auth;
  final Database db;
  final String userId;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => new _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  //Logout button

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Logout',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: signOut,
          ),
        ));
  }

  //Facebook Login

  bool _isLoggedInFacebook = false;
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
          _isLoggedInFacebook = true;
        });
        //Add Facebook userId to database
        widget.db.setFacebookId(widget.userId, profile['id']);
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
    //Remove Facebook Id from database
    widget.db.setFacebookId(widget.userId, null);
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
        //Set twitter userId in database
        widget.db.setTwitterInfo(widget.userId, result.session.toMap());
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
    //Remove twitter userId from database
    widget.db.setTwitterInfo(widget.userId, null);
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

  //Instagram login

  static String APP_ID = "190520052359534";
  static String APP_SECRET = "93ce3e33973fcbbe28baced8bf16080d";

  bool _isLoggedInInstagram = false;

  void _loginInstagram() async {
    log("Trying to log into insta");
    final insta.Token token = await insta.getToken(APP_ID,
        APP_SECRET);
    if(token != null){
      setState(() {
        _isLoggedInInstagram = true;
      });
      log(token.toString());
    }
    else{
      log("Error");
      setState(() {
        _isLoggedInInstagram = false;
      });
    }
  }

  void _logoutInstagram() async {
    setState(() {
      _isLoggedInInstagram = false;
    });
  }

  Widget instagramButton(){
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: _isLoggedInInstagram
            ? SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text("Logout of Instagram",
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              _logoutInstagram();
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
            child: new Text("Login with Instagram",
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              _loginInstagram();
            },
          ),
        ));
  }



  //Build Components
  @override
  Widget build(BuildContext context) {
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
                      instagramButton(),
                      showPrimaryButton(),
                    ],
                  ),
                ))
        )
      );
  }
}