//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:kronogram/UI_pages/values/values.dart';

abstract class ListItem {}

// A ListItem that contains data to display a heading.
class FacebookPost implements ListItem {
  final String userPosted;
  final String action;
  final String postBody;

  FacebookPost(
    this.userPosted,
    this.action,
    this.postBody,
  );
}

// A ListItem that contains data to display a message.
class InstagramPost implements ListItem {
  final String userPosted;
  final String action;
  final String postBody;
  final Container postImage;

  InstagramPost(this.userPosted, this.action, this.postBody, this.postImage);
}

class generalPost implements ListItem {
  final String platform;
  final String userPosted;
  final String action;
  final String postBody;
  //final Container postImage;

  generalPost(this.platform, this.userPosted, this.action, this.postBody);
}

class userTestPost {
  userTestPost();
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List getpostlists(int n) {
    List<generalPost> posts = List<generalPost>();
    for (int i = 0; i < n; i++) {
      if (i % 4 == 0) {
        posts.add(generalPost(
            "Facebook", "USER $i", "posted", "Random post body message $i"));
      }
      if (i % 4 == 1) {
        posts.add(generalPost(
            "Instagram", "USER $i", "posted", "Random post body message $i"));
      } else {
        posts.add(generalPost(
            "Twitter", "USER $i", "tweeted", "Random post body message $i"));
      }
    }
    return posts;
    //List getLists(int n){
  }
}
