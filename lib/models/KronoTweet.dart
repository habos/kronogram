import 'package:flutter/material.dart';
import 'package:kronogram/models/KronoPost.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';

class KronoTweet extends KronoPost {

  Tweet tweet;

  KronoTweet(this.tweet);

  @override
  Widget createPostWidget() {
    return TweetView.fromTweet(tweet);
  }
}