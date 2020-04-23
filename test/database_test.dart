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

  /// this group of tests relates to the friends network stored in the database
  group('relationships', () {

    test('getRelationship returns a snapshot of the relationship', () async {
      Database db = MockDB();
      DocumentSnapshot snapshot = MockSnap();
      snapshot.data['user1_id'] = '111111111';
      snapshot.data['user2_id'] = '999999999';
      snapshot.data['status'] = 3;
      when(db.getRelationship('111111111', '999999999'))
          .thenAnswer((_) async => snapshot);
      DocumentSnapshot snap = await db.getRelationship('111111111', '999999999');
      expect(snap.data['status'], 3);
      expect(snap.data['user1_id'], '111111111');
      expect(snap.data['user2_id'], '999999999');
    });

    test('relationshipExists returns a map with the status and id', () async {
      Database db = MockDB();
      when(db.relationshipExists('111111111', '999999999'))
          .thenAnswer((_) async => {'status': 3, 'relationshipID': '123'});
      Map relationship = await db.relationshipExists('111111111', '999999999');
      expect(relationship['status'], 3);
      expect(relationship['relationshipID'], '123');
    });

    test('orderUsersRelationships orders the usernames and returns the friend as the lowest', () async {
      Database db = MockDB();
      when(db.orderUsersRelationship('zyxw', 'abcd'))
          .thenAnswer((realInvocation) => {'low':'friend', 'user1': 'abcd', 'user2':'zyxw'});
      Map relationship = db.orderUsersRelationship('zyxw', 'abcd');
      expect(relationship['low'], 'friend');
      expect(relationship['user1'], 'abcd');
      expect(relationship['user2'], 'zyxw');
    });

    test('orderUsersRelationships orders the usernames and returns the user as the lowest', () async {
      Database db = MockDB();
      when(db.orderUsersRelationship('abcd', 'zyxw'))
          .thenAnswer((realInvocation) => {'low':'user', 'user1': 'abcd', 'user2':'zyxw'});
      Map relationship = db.orderUsersRelationship('abcd', 'zyxw');
      expect(relationship['low'], 'user');
      expect(relationship['user1'], 'abcd');
      expect(relationship['user2'], 'zyxw');
    });
  });
}