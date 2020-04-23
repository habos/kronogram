import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/colors.dart';
import 'package:kronogram/models/krono_post.dart';
import 'package:kronogram/models/sm_platform.dart';
import 'package:kronogram/styles/text_styles.dart';
import 'package:kronogram/utils/date_utils.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:kronogram/models/location.dart';

/// KronoTweet wraps a [Tweet] object so that it
/// fulfills the [KronoPost] interface
class KronoTweet implements KronoPost {
  final Tweet _tweet;
  final DateTime _creationTime;
  final TwitterLocationData _locationData;

  /// Constructs a KronoTweet object given a [Tweet] object
  /// The constructor also parses the createdAt field of
  /// the Tweet and stores it as a [DateTime] object
  KronoTweet(this._tweet, [this._locationData])
      : _creationTime = parseTwitterCreationTime(_tweet.createdAt);

  /// Returns a [TweetView] Widget displaying the underlying tweet.
  @override
  Widget createPostWidget() {
  return Container(
      padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: AppColors.primaryBackground,
      ),
      child: TweetView.fromTweet(_tweet, textStyle: defaultTweetTextStyle));
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
  Location getLocation() {
    return _locationData;
  }

  @override
  Map<String, dynamic> toJson() => {
        'userId': _tweet.user.id,
        'createdAt': _creationTime,
        'caption': _tweet.text,
        'tweetData': _tweet,
        'locationData' : _locationData
      };

  static KronoTweet fromJson(Map<String, dynamic> json) {
    Tweet tweet = json['tweetData'];
    TwitterLocationData location = new TwitterLocationData();
    location.latitude = json['location']['latitude'];
    location.longitude = json['location']['longitude'];
    return KronoTweet(tweet, location);
  }
}
