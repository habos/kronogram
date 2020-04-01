import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kronogram/UI_pages/user_pages/user_page.dart';
import 'package:kronogram/pages/test_fb.dart';
import 'package:kronogram/pages/test_instagram.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:kronogram/services/instagram_login.dart' as insta;
import 'dart:core';
import 'dart:developer';
import 'package:kronogram/pages/test_twitter_requests.dart';
import 'package:kronogram/services/remote_config.dart';
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

  void onContinuePressed(BuildContext context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => UserPage()));
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
            child: new Text('Continue',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () => widget.onContinuePressed(context),
          ),
        ));
  }

  //Facebook Login

  bool _isLoggedInFacebook = false;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async {
    final result = await facebookLogin
        .logInWithReadPermissions(['user_posts', 'user_likes']);
    if (result.accessToken == null) {
      facebookLogin.logOut();
    }
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        setState(() {
          _isLoggedInFacebook = true;
        });
        //Add Facebook userId to database
        widget.db.setFacebookInfo(widget.userId, result.accessToken.toMap());
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedInFacebook = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedInFacebook = false);
        print(result.errorMessage);
        break;
    }
  }

  _FacebookLogout() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedInFacebook = false;
    });
    //Remove Facebook Id from database
    widget.db.setFacebookInfo(widget.userId, null);
  }

  Widget FacebookButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child:
      _isLoggedInFacebook ? SignInButtonBuilder(
        height: 40.0,
        fontSize: 19,
        text: "Logout of Facebook",
        icon: FontAwesomeIcons.facebook,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        backgroundColor: Color(0xff3b5998),
        onPressed: () { _FacebookLogout(); },
      )
          : SignInButtonBuilder(
        height: 40.0,
        fontSize: 19,
        text: "Login to Facebook",
        icon: FontAwesomeIcons.facebook,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        backgroundColor: Color(0xff3b5998),
        onPressed: () { _loginWithFB(); },
      ),
    );
  }

  //Twitter Login

  static final Future<TwitterLogin> twitterLoginFuture = getTwitterLogin();

  bool _isLoggedInTwitter = false;

  void _loginTwitter() async {
    TwitterLogin twitterLogin = await twitterLoginFuture;
    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        log("Twitter Login Success");
        setState(() => _isLoggedInTwitter = true);
        //Set twitter userId in database
        widget.db.setTwitterInfo(widget.userId, result.session.toMap());
        break;
      case TwitterLoginStatus.cancelledByUser:
        log('Login cancelled by user.');
        setState(() => _isLoggedInTwitter = false);
        break;
      case TwitterLoginStatus.error:
        log('Login error: ${result.errorMessage}');
        setState(() => _isLoggedInTwitter = false);
        break;
    }
  }

  void _logoutTwitter() async {
    TwitterLogin twitterLogin = await twitterLoginFuture;
    await twitterLogin.logOut();

    setState(() {
      _isLoggedInTwitter = false;
    });
    //Remove twitter userId from database
    widget.db.setTwitterInfo(widget.userId, null);
  }

  Widget twitterButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child:
      _isLoggedInTwitter ? SignInButtonBuilder(
        height: 40.0,
        fontSize: 19,
        text: "Logout of Twitter",
        icon: FontAwesomeIcons.twitter,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        backgroundColor: Color(0xff00acee),
        onPressed: () { _logoutTwitter(); },
      )
          : SignInButtonBuilder(
        height: 40.0,
        fontSize: 19,
        text: "Login to Twitter",
        icon: FontAwesomeIcons.twitter,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        backgroundColor: Color(0xff00acee),
        onPressed: () { _loginTwitter(); },
      ),
    );
  }

  //Instagram login

  bool _isLoggedInInstagram = false;

  void _loginInstagram() async {
    final insta.Token token = await insta.getToken();
    if (token != null) {
      setState(() {
        _isLoggedInInstagram = true;
      });
      log(token.toString());
      widget.db.setInstagramInfo(widget.userId, token.toMap());
    } else {
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
    widget.db.setInstagramInfo(widget.userId, null);
  }

  Widget instagramButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child:
      _isLoggedInInstagram ? SignInButtonBuilder(
        height: 40.0,
        fontSize: 19,
        text: "Logout of Instagram",
        icon: FontAwesomeIcons.instagram,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        backgroundColor: Color(0xffe95950),
        onPressed: () { _logoutInstagram(); },
      )
          : SignInButtonBuilder(
        height: 40.0,
        fontSize: 19,
        text: "Login to Instagram",
        icon: FontAwesomeIcons.instagram,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        backgroundColor: Color(0xffe95950),
        onPressed: () { _loginInstagram(); },
      ),
    );
  }

  //Build Components
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: new Container(
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
                ))));
  }
}
