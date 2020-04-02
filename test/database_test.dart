import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kronogram/models/insta_post_data.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/services/database.dart';
import 'package:mockito/mockito.dart';

class MockDB extends Mock implements Database {
  int id;
}

class MockSnap extends Mock implements DocumentSnapshot {
  Map<String, dynamic> data = new Map();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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
  });
}