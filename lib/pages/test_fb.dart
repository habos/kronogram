import 'package:flutter/material.dart';
import 'package:kronogram/models/krono_fb_post.dart';
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
  List<KronoFacebookPost> posts = new List();
  Widget facebookExample = new Container();

  Future getPosts() async {
    var fbUser = await widget.db.getFacebookInfo(widget.userId);
    final token = fbUser['token'];
    final graphResponse = await http.get(
        'https://graph.facebook.com/me/?fields=posts.limit(6){id,created_time,name,message,place,attachments{media{image},type,subattachments}}&access_token=${token}');
    final profile = JSON.jsonDecode(graphResponse.body);
//    print(profile['posts']['data']['attachments']);
    for (var jsonPost in profile['posts']['data']) {
      FacebookPostData fbPost =
          new FacebookPostData.fromJson(jsonPost, widget.userId);

//      posts.add(new KronoFacebookPost(fbPost));
    }

    setState(() {
      facebookExample = posts[0].createPostWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Facebook Request'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              getPosts();
            },
            color: Colors.blue,
            child: new Text('Request Posts'),
          ),
          facebookExample
        ],
      ),
    );
  }
}
