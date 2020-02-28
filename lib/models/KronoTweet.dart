import 'package:flutter/material.dart';
import 'package:kronogram/models/KronoPost.dart';
import 'package:kronogram/models/SMPlatform.dart';
import 'package:kronogram/utils/DateUtils.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';

/// KronoTweet wraps a [Tweet] object so that it
/// fulfills the [KronoPost] interface
class KronoTweet implements KronoPost {

  Tweet tweet;
  DateTime creationTime;

  static const _defaultTextStyle = const TextStyle(
    fontSize: 18.0,
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.w300,
    height: 1.1,
    letterSpacing: 0.1,
    color: Colors.black,
  );

  /// Constructs a KronoTweet object given a [Tweet] object
  /// The constructor also parses the createdAt field of
  /// the Tweet and stores it as a [DateTime] object
  KronoTweet(Tweet tweet) {
   this.tweet = tweet;
   this.creationTime = parseTwitterCreationTime(tweet.createdAt);
  }

  /// Returns a [TweetView] Widget displaying the underlying tweet.
  @override
  Widget createPostWidget() {
    return TweetView.fromTweet(tweet, textStyle: _defaultTextStyle);
  }

  /// Returns a [DateTime] object representing the time this tweet
  /// was made.
  @override
  DateTime getCreationTime() {
    return creationTime;
  }

  /// Returns [SMPlatform.twitter] since this post was made on Twitter.
  @override
  SMPlatform getPlatform() {
    return SMPlatform.twitter;
  }
}