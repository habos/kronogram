import 'package:flutter_test/flutter_test.dart';
import 'package:kronogram/models/insta_post_data.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:kronogram/models/post.dart';
import 'package:tweet_ui/models/api/tweet.dart';

void main() {
  group('krono_post getPlatform', () {
    test('getPlatform should return facebook', () {
      FacebookPostData fbPostData = new FacebookPostData();
      KronoFacebookPost fbPost = new KronoFacebookPost(fbPostData);
      expect(fbPost.getPlatform().toString(), "SMPlatform.facebook");
    });

    test('getPlatform should return instagram', () {
      InstaPostData instaPostData = new InstaPostData();
      KronoInstaPost instaPost = new KronoInstaPost(instaPostData);
      expect(instaPost.getPlatform().toString(), "SMPlatform.instagram");
    });

    test('getPlatform should return twitter', () {
      Tweet tweetData = new Tweet();
      KronoTweet tweet = new KronoTweet(tweetData);
      expect(tweet.getPlatform().toString(), "SMPlatform.twitter");
    });
  });
}