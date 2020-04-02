import 'package:flutter_test/flutter_test.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:kronogram/services/globals.dart' as globals;
import 'package:matcher/matcher.dart';

void main() {
  group('API calls', () {
    test('requestInstaPosts should return a list of KronoInstaPosts', () async {
      String userId = 'N9y8hZRWPwYBrsgD9Kci@AEuFqP2';
      var instaUser = await globals.db.getInstagramInfo(userId);
      var posts = await globals.APIcaller.requestInstaPosts(instaUser);
      expect(posts, isA<List<KronoInstaPost>>());
    });

    test('requestFbPosts should return a list of KronoFacebookPosts', () async {
      String userId = 'N9y8hZRWPwYBrsgD9Kci@AEuFqP2';
      var fbUser = await globals.db.getFacebookInfo(userId);
      var posts = await globals.APIcaller.requestFbPosts(fbUser);
      expect(posts, isA<List<KronoFacebookPost>>());
    });

    test('requestTweets should return a list of KronoTweets', () async {
      String userId = 'N9y8hZRWPwYBrsgD9Kci@AEuFqP2';
      var twitterUser = await globals.db.getTwitterInfo(userId);
      var posts = await globals.APIcaller.requestTweets(twitterUser);
      expect(posts, isA<List<KronoTweet>>());
    });
  });
}