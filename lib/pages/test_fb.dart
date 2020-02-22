import 'package:flutter/material.dart';
import 'dart:convert' as JSON;
import 'dart:core';
import 'package:twitter_api/twitter_api.dart';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/services/post.dart';

class FacebookPage extends StatefulWidget {
  FacebookPage({Key key, this.auth, this.userId, this.logoutCallback, this.db})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final Database db;

  @override
  State<StatefulWidget> createState() => new _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {

  Future getPosts() {

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Facebook Request'),
      ),
      body: Stack(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
            },
            color: Colors.blue,
            child: new Text('Request Posts'),
          ),
        ],
      ),
    );
  }
}
