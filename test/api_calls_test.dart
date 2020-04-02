import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:kronogram/services/globals.dart' as globals;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('API calls', () {
    test('requestInstaPosts should return null when invalid user token', () async {
      var instaUser = {'token' : '123'};
      var posts = await globals.APIcaller.requestInstaPosts(instaUser);
      expect(posts, isNull);
    });

    test('requestFbPosts should return null when invalid user token', () async {
      var fbUser = {'token' : '123'};
      var posts = await globals.APIcaller.requestFbPosts(fbUser);
      expect(posts, isNull);
    });

    test('requestTweets should return null when invalid user tokens', () async {
      var twitterUser = {'token' : '123', 'secret' : 'abc'};
      var posts = await globals.APIcaller.requestTweets(twitterUser);
      expect(posts, isNull);
    });
  });
}