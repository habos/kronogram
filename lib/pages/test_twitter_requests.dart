import 'package:flutter/material.dart';
import 'package:kronogram/models/KronoTweet.dart';
import 'package:tweet_ui/models/api/tweet.dart';
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
  List tweets = new List();
  Widget tweetExample = Container(color: Colors.white);

  Future getTweets() async {
    var twitterUser = await widget.db.getTwitterInfo(widget.userId);

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
        "count":"3",
      },
    );


    var res = await twitterRequest;
    print(res.body);  // the response in json

    var tweetResponse = JSON.jsonDecode(res.body); // decode json tweet object

    for (int i = 0; i < tweetResponse.length; i++) {
      tweets.add(new KronoTweet(Tweet.fromJson(tweetResponse[i])));
    }

    setState(() {
      tweetExample = tweets[0].createPostWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Twitter Request'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              getTweets();
            },
            color: Colors.blue,
            child: new Text('Request Tweets'),
          ), tweetExample
        ],
      ),
    );
  }
}
