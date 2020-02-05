import 'package:flutter/material.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;


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

  bool _isLoggedIn = false;
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
          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }

  }

  _FacebookLogout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }




  //Twitter Login

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: 'kkOvaF1Mowy4JTvCxKTV5O1WF',
    consumerSecret: 'ZECGsI6UUDBEUVGkJe4S5vd0FGqGxC3wMJCgsXgPRfjSwRFnyH',
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(userProfile["picture"]["data"]["url"], height: 50.0, width: 50.0,),
                Text(userProfile["name"]),
                OutlineButton( child: Text("Logout"), onPressed: (){
                  _FacebookLogout();
                },)
              ],
            )
                : Center(
              child: OutlineButton(
                child: Text("Login with Facebook"),
                onPressed: () {
                  _loginWithFB();
                },
              ),
            )),
      ),
    );
  }
}