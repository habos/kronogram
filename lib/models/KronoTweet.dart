import 'package:flutter/material.dart';
import 'package:kronogram/models/KronoPost.dart';
import 'package:kronogram/utils/DateUtils.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';

class KronoTweet extends KronoPost {

  Tweet tweet;
  DateTime creationTime;

  KronoTweet(Tweet tweet) {
   this.tweet = tweet;
   this.creationTime = parseTwitterCreationTime(tweet.createdAt);
  }

  @override
  Widget createPostWidget() {
    return TweetView.fromTweet(tweet);
  }

  @override
  DateTime getCreationTime() {
    return creationTime;
  }
}