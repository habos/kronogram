import 'package:flutter/material.dart';
import 'dart:convert' as JSON;
import 'dart:core';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:http/http.dart' as http;
import 'package:kronogram/models/post.dart';

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


  Future getPosts() async{
    List<FacebookPostData> posts = new List();
    var fbUser = await widget.db.getFacebookInfo(widget.userId);
    final token = fbUser['token'];
    final graphResponse = await http.get('https://graph.facebook.com/me/?fields=posts.limit(6){id,created_time,name,message,place,attachments{media{image},type,subattachments}}&access_token=${token}');
    final profile = JSON.jsonDecode(graphResponse.body);
//    print(profile['posts']['data']);
    for(var x in profile['posts']['data']) {
      posts.add(new FacebookPostData.fromJson(x, widget.userId));
    }
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
