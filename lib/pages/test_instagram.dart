import 'package:flutter/material.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'dart:convert' as JSON;
import 'dart:core';
import 'package:kronogram/services/database.dart';
import 'package:kronogram/services/authentication.dart';
import 'package:kronogram/models/insta_post_data.dart';
import 'package:http/http.dart' as http;
import 'package:kronogram/services/api_requests.dart';

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
  List<KronoInstaPost> posts;
  Widget instagramExample = new Container();

  Future getPosts() async {
    var instaUser = await widget.db.getInstagramInfo(widget.userId);
    APIcalls APIcaller;
    posts = await APIcaller.requestInstaPosts(instaUser);
//    final token = instaUser['token'];
//    final graphResponse = await http.get(
//        'https://graph.instagram.com/me?fields=media{id,caption,media_type,media_url,timestamp,children{media_type,media_url}}&access_token=$token');
//    final jsonPostHistory = JSON.jsonDecode(graphResponse.body);
////    print(jsonPostHistory['media']['data'][1]);
//    for (var jsonPost in jsonPostHistory['media']['data']) {
//      InstaPostData instaPost = new InstaPostData.fromJson(jsonPost);
//      posts.add(new KronoInstaPost(instaPost));
//    }

    setState(() {
      instagramExample = posts[1].createPostWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Instagram Request'),
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
          instagramExample
        ],
      ),
    );
  }
}
