import 'package:flutter/material.dart';
import 'dart:convert' as JSON;
import 'dart:core';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/models/post.dart';
import 'package:http/http.dart' as http;

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
  Future getPosts() async {
    var fbUser = await widget.db.getFacebookInfo(widget.userId);
    final token = fbUser['token'];
    final graphResponse = await http.get(
        'https://graph.facebook.com/me/posts?fields=id,created_time,message,place&access_token=${token}');
    final profile = JSON.jsonDecode(graphResponse.body);
    print(profile);
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
              getPosts();
            },
            color: Colors.blue,
            child: new Text('Request Posts'),
          ),
        ],
      ),
    );
  }
}
