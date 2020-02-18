
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'dart:core';
import 'package:twitter_api/twitter_api.dart';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/authentication.dart';

class TwitterPage extends StatefulWidget {
  TwitterPage({Key key, this.auth, this.userId, this.logoutCallback, this.db})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final Database db;

  @override
  State<StatefulWidget> createState() => new _TwitterPageState();
}

class _TwitterPageState extends State<TwitterPage> {

  Future getTweets() async{
      var twitterUser = await widget.db.getTwitterInfo(widget.userId);
//      print(twitterUser);

    final _twitterOauth = new twitterApi(
        consumerKey: 'JZScfVJ2TnkzVHy7lS7XHGU1z',
        consumerSecret: 'fk9BSlBe6mDnioJeoIc7thAQeODgnbEBZAJoBsuPVGYG8PmMQW',
        token: twitterUser['token'],
        tokenSecret: twitterUser['secret']
    );

    Future twitterRequest = _twitterOauth.getTwitterRequest(
      "GET",
      "statuses/user_timeline.json",
      options: {
        "screen_name": twitterUser['username'],
        "count":"1",
        "trim_user":"true",
        "tweet_mode":"extended",
      },
    );

    var res = await twitterRequest;

    print("res");
    print(res.statusCode);
    print(res.body);

    var tweets = JSON.jsonDecode(res.body);
    print("tweets");
    print(tweets);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Twitter Request'),
      ),
      body: Stack(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              getTweets();
            },
            color: Colors.blue,
            child: new Text('Request Tweets'),
          ),
        ],
      ),
    );
  }


//  String _tweet = 'none';
//
//  changeText(String $txt) {
//    setState(() {
//      _tweet = $txt;
//    });
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Twitter Request'),
//      ),
//      body: Stack(
//        children: <Widget>[
//          RaisedButton(
//            onPressed: () {
//              getTweets();
//            },
//            color: Colors.blue,
//            child: new Text('Request Tweets'),
//          ),
//          Text('$_tweet'),
//        ],
//      ),
//    );
//  }
//
//
//   getTweets() async {
//    final _tweetResponse = await http.get('https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=TwitterDev&count=1');
//    final _tweetDecoded = JSON.jsonDecode(_tweetResponse.body);
//    changeText(_tweetDecoded['id']);
//  }

}
