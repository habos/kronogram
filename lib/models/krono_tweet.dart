import 'package:flutter/material.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/sm_platform.dart';
import 'package:kronogram/styles/text_styles.dart';
import 'package:kronogram/utils/date_utils.dart';
import 'package:kronogram/widgets/twitter_post_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';

/// KronoTweet wraps a [Tweet] object so that it
/// fulfills the [KronoPost] interface
class KronoTweet implements KronoPost {
  final Tweet _tweet;
  final DateTime _creationTime;

  /// Constructs a KronoTweet object given a [Tweet] object
  /// The constructor also parses the createdAt field of
  /// the Tweet and stores it as a [DateTime] object
  KronoTweet(this._tweet)
      : _creationTime = parseTwitterCreationTime(_tweet.createdAt);

  /// Returns a [TweetView] Widget displaying the underlying tweet.
  @override
  Widget createPostWidget() {
    return TwitterPostView.fromTweetWidget(TweetView.fromTweet(_tweet, textStyle: defaultTweetTextStyle),_creationTime);
  }

  /// Returns a [DateTime] object representing the time this tweet
  /// was made.
  @override
  DateTime getCreationTime() {
    return _creationTime;
  }

  /// Returns [SMPlatform.twitter] since this post was made on Twitter.
  @override
  SMPlatform getPlatform() {
    return SMPlatform.twitter;
  }

  @override
  int getPostID() {
    return int.parse(_tweet.idStr);
  }

  @override
  Map<String, dynamic> toJson() => {
        'userId': _tweet.user.id,
        'createdAt': _creationTime,
        'caption': _tweet.text,
        'tweetData': _tweet,
      };

  static KronoTweet fromJson(Map<String, dynamic> json) {
    Tweet tweet = json['tweetData'];
    return KronoTweet(tweet);
  }
}
