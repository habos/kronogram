import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kronogram/models/insta_post_data.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_tweet.dart';
import 'package:kronogram/models/post.dart';
import 'package:kronogram/services/database.dart';
import 'package:mockito/mockito.dart';
import 'package:tweet_ui/models/api/tweet.dart' as TweetUI;

class MockDB extends Mock implements Database {
  int id;
}

class MockSnap extends Mock implements DocumentSnapshot {
  Map<String, dynamic> data = new Map();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  /// This group of tests ensures that, after uploading serialized
  /// representations of social media posts to the database, we can retrieve
  /// them and reconstruct them.
  group('Database, ', () {
    test('getIGPost and addToInstagramPosts should work correctly', () async {
      Database db = MockDB();
      DocumentSnapshot snapshot = MockSnap();
      snapshot.data['postId'] = 999999999;
      when(db.getIGPost(999999999)).thenAnswer((_) async => snapshot);
      InstaPostData data = new InstaPostData();
      data.id = 999999999;
      KronoInstaPost instaPost = new KronoInstaPost(data);
      await db.addToInstagramPosts(instaPost);
      DocumentSnapshot snap = await db.getIGPost(999999999);
      expect(snap.data['postId'], 999999999);
    });

    test('getFacebookPost and addToFacebookPosts should work correctly', () async {
      Database db = MockDB();
      DocumentSnapshot snapshot = MockSnap();
      snapshot.data['postId'] = 999999999;
      when(db.getFacebookPost(999999999)).thenAnswer((_) async => snapshot);
      FacebookPostData data = new FacebookPostData();
      data.id='999999999';
      KronoFacebookPost fbPost = new KronoFacebookPost(data);
      await db.addToFacebookPosts(fbPost);
      DocumentSnapshot snap = await db.getFacebookPost(999999999);
      expect(snap.data['postId'],999999999);
    });

    test('getTweet and addToTwitterPosts should work correctly', () async {
      Database db = MockDB();
      DocumentSnapshot snapshot = MockSnap();
      snapshot.data['postId'] = 999999999;
      when(db.getTweet(999999999)).thenAnswer((_) async => snapshot);
      TweetUI.Tweet data = new TweetUI.Tweet();
      data.id=999999999;
      KronoTweet tweet = new KronoTweet(data);
      await db.addToTwitterPosts(tweet);
      DocumentSnapshot snap = await db.getTweet(999999999);
      expect(snap.data['postId'], 999999999);
    });
  });
}