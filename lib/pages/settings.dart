import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/user_pages/user_page.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/pages/profile_page.dart';
import 'package:kronogram/pages/root_page.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:kronogram/services/instagram_login.dart' as insta;
import 'package:kronogram/services/globals.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:core';
import 'dart:developer';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:kronogram/services/remote_config.dart';
import 'package:kronogram/services/database.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.userId, this.logoutCallback}) : super(key: key);

  final BaseAuth auth = globals.auth;
  final Database db = globals.db;
  final String userId;
  final VoidCallback logoutCallback;

  @override
  State<StatefulWidget> createState() => new _SettingsPageState();

  void onBackPressed(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              UserPage(userId: userId, logoutCallback: logoutCallback)));

  void onLogoutPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => RootPage()));

  void onChangePressed(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => ProfilePage(userId: userId, logoutCallback: logoutCallback,)));
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoggedInFacebook;
  bool _isLoggedInTwitter;
  bool _isLoggedInInstagram;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      String userId = user.uid;
      widget.db.checkFacebookInfo(userId).then((value) {
        setState(() {
          if (value) {
            _isLoggedInFacebook = true;
          } else {
            _isLoggedInFacebook = false;
          }
        });
      });
      widget.db.checkTwitterInfo(userId).then((val) {
        setState(() {
          if (val) {
            _isLoggedInTwitter = true;
          } else {
            _isLoggedInTwitter = false;
          }
        });
      });
      widget.db.checkInstagramInfo(userId).then((val) {
        setState(() {
          if (val) {
            _isLoggedInInstagram = true;
          } else {
            _isLoggedInInstagram = false;
          }
        });
      });
    });
  }

  //Logout button
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  Widget showBackButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: AppColors.randomButton2,
            child: new Text('Go Back',
                style: new TextStyle(
                    fontSize: 20.0, color: AppColors.randomButtonText2)),
            onPressed: () => widget.onBackPressed(context),
          ),
        ));
  }

  Widget showLogoutButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: AppColors.randomButton2,
              child: new Text('Logout',
                  style: new TextStyle(
                      fontSize: 20.0, color: AppColors.randomButtonText2)),
              onPressed: () => [signOut(), widget.onLogoutPressed(context)]),
        ));
  }

  //Facebook Login

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
      child: _isLoggedInFacebook
          ? SignInButtonBuilder(
              height: 40.0,
              fontSize: 19,
              text: "Logout of Facebook",
              icon: FontAwesomeIcons.facebook,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              backgroundColor: AppColors.facebookColor,
              onPressed: () {
                _FacebookLogout();
              },
            )
          : SignInButtonBuilder(
              height: 40.0,
              fontSize: 19,
              text: "Login to Facebook",
              icon: FontAwesomeIcons.facebook,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              backgroundColor: AppColors.facebookColor,
              onPressed: () {
                _loginWithFB();
              },
            ),
    );
  }

  //Twitter Login

  static final Future<TwitterLogin> twitterLoginFuture = getTwitterLogin();

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

  Widget TwitterButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: _isLoggedInTwitter
          ? SignInButtonBuilder(
              height: 40.0,
              fontSize: 19,
              text: "Logout of Twitter",
              icon: FontAwesomeIcons.twitter,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              backgroundColor: AppColors.twitterColor,
              onPressed: () {
                _logoutTwitter();
              },
            )
          : SignInButtonBuilder(
              height: 40.0,
              fontSize: 19,
              text: "Login to Twitter",
              icon: FontAwesomeIcons.twitter,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              backgroundColor: AppColors.twitterColor,
              onPressed: () {
                _loginTwitter();
              },
            ),
    );
  }

  //Instagram login

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

  Widget InstagramButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: _isLoggedInInstagram
          ? SignInButtonBuilder(
              height: 40.0,
              fontSize: 19,
              text: "Logout of Instagram",
              icon: FontAwesomeIcons.instagram,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              backgroundColor: AppColors.instagramColor,
              onPressed: () {
                _logoutInstagram();
              },
            )
          : SignInButtonBuilder(
              height: 40.0,
              fontSize: 19,
              text: "Login to Instagram",
              icon: FontAwesomeIcons.instagram,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              backgroundColor: AppColors.instagramColor,
              onPressed: () {
                _loginInstagram();
              },
            ),
    );
  }

  Widget showChangeButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: AppColors.randomButton2,
            child: new Text('Update Profile',
                style: new TextStyle(
                    fontSize: 20.0, color: AppColors.randomButtonText2)),
            onPressed: () => widget.onChangePressed(context),
          ),
        ));
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
                      TwitterButton(),
                      InstagramButton(),
                      showChangeButton(),
                      showLogoutButton(),
                      showBackButton(),
                    ],
                  ),
                ))));
  }
}
