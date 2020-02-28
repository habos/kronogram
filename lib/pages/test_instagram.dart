import 'package:flutter/material.dart';
import 'dart:convert' as JSON;
import 'dart:core';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/models/KronoInstaPost.dart';
import 'package:http/http.dart' as http;

class InstagramPage extends StatefulWidget {
  InstagramPage({Key key, this.auth, this.userId, this.logoutCallback, this.db})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final Database db;

  @override
  State<StatefulWidget> createState() => new _InstagramPageState();
}

class _InstagramPageState extends State<InstagramPage> {
  List<KronoInstaPost> posts = new List();

  Future getPosts() async {
    var instaUser = await widget.db.getInstagramInfo(widget.userId);
    final token = instaUser['token'];
    final graphResponse = await http.get(
        'https://graph.instagram.com/me/media?fields=id,caption,media_type,media_url,timestamp&access_token=$token');
    final jsonPostHistory = JSON.jsonDecode(graphResponse.body);
    print(jsonPostHistory);
    for (var jsonPost in jsonPostHistory['data']) {
      KronoInstaPost instaPost = new KronoInstaPost.fromJson(jsonPost);
      if (jsonPost['media_type'] == 'CAROUSEL_ALBUM') {
        var id = instaPost.getID();
        var albumResponse = await http.get(
            'https://graph.instagram.com/$id/children?fields=media_type,media_url&access_token=$token');
        var res = JSON.jsonDecode(albumResponse.body);
        for (var y in res['data']) {
          instaPost.addMedia(y['media_type'], y['media_url']);
        }
      }
      posts.add(instaPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Instagram Request'),
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
