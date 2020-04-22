import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kronogram/models/krono_fb_post.dart';
import 'package:kronogram/models/krono_insta_post.dart';
import 'package:kronogram/models/krono_tweet.dart';

// All default parameters are the defaults for a new user.

abstract class BaseDatabase {
  Future<bool> isNewUser(String userID);
  Future<void> setIsNewUser(String userID, bool status);

  Future<String> getUsername(String userID);
  Future<void> setUsername(String userID, String username);

  Future<Map> getFacebookInfo(String userID);
  Future<void> setFacebookInfo(String userID, Map facebookId);
  Future<bool> checkFacebookInfo(String userID);

  Future<Map> getTwitterInfo(String userID);
  Future<void> setTwitterInfo(String userID, Map info);
  Future<bool> checkTwitterInfo(String userID);

  Future<Map> getInstagramInfo(String userID);
  Future<void> setInstagramInfo(String userID, Map info);
  Future<bool> checkInstagramInfo(String userID);
}

class Database implements BaseDatabase {
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionName = "users";
  final String _fbPostsCollectionName = "facebookPosts";
  final String _tweetsCollectionName = "twitterPosts";
  final String _igPostsCollectionName = "instagramPosts";
  final String _newUserStatusField = "is_new_user";
  final String _usernameField = "username";
  final String _facebookInfoField = "facebook_info";
  final String _twitterInfoField = "twitter_info";
  final String _instagramInfoField = "instagram_info";
  final String _timelineSummaryField = "timeline";

  Future<void> setFieldInUsers(String userID, String fieldName, var value) {
    return _firestore
        .collection(_usersCollectionName)
        .document(userID)
        .setData({fieldName: value}, merge: true);
  }

  Future<QuerySnapshot> getUsernames() {
    return _firestore.collection(_usersCollectionName)
        .where(_usernameField)
        .getDocuments();
  }

  CollectionReference getUserTimelineSummary(String userID) {
    return getUserDocumentRef(userID).collection(_timelineSummaryField);
  }

  Future<void> addToUserTimelineSummary(String userID, int postID,
      DateTime creationTime, String platform) {
    return _firestore
        .collection(_usersCollectionName)
        .document(userID)
        .collection(_timelineSummaryField)
        .document()
        .setData({
      'postID': postID,
      'creationTime': creationTime,
      'platform': platform
    });
  }

  Future<void> addToFacebookPosts(KronoFacebookPost fbPost) {
    return _firestore
        .collection(_fbPostsCollectionName)
        .document(fbPost.getPostID().toString())
        .setData(fbPost.toJson());
  }

  Future<void> addToTwitterPosts(KronoTweet tweet) {
    return _firestore
        .collection(_tweetsCollectionName)
        .document(tweet.getPostID().toString())
        .setData(tweet.toJson());
  }

  Future<void> addToInstagramPosts(KronoInstaPost igPost) {
    return _firestore
        .collection(_igPostsCollectionName)
        .document(igPost.getPostID().toString())
        .setData(igPost.toJson());
  }

  Future<DocumentSnapshot> getFacebookPost(int postID) {
    return _firestore
        .collection(_fbPostsCollectionName)
        .document(postID.toString())
        .get();
  }

  Future<DocumentSnapshot> getIGPost(int postID) {
    return _firestore
        .collection(_igPostsCollectionName)
        .document(postID.toString())
        .get();
  }

  Future<DocumentSnapshot> getTweet(int postID) {
    return _firestore
        .collection(_tweetsCollectionName)
        .document(postID.toString())
        .get();
  }

  DocumentReference getUserDocumentRef(String userID) {
    return _firestore.collection(_usersCollectionName).document(userID);
  }

  Future<DocumentSnapshot> getUserDocumentSnapshot(String userID) {
    return getUserDocumentRef(userID).get();
  }

  @override
  Future<bool> isNewUser(String userID) async {
    var snapshot = await getUserDocumentSnapshot(userID);
    return snapshot.data.remove(_newUserStatusField);
  }

  @override
  Future<void> setIsNewUser(String userID, bool status) {
    return setFieldInUsers(userID, _newUserStatusField, status);
  }

  Future<String> getUsername(String userID) async {
    var snapshot = await getUserDocumentSnapshot(userID);
    return snapshot.data.remove(_usernameField);
  }

  Future<void> setUsername(String userID, String username) async {
    return setFieldInUsers(userID, _usernameField, username);
  }

  Future<Map> getFacebookInfo(String userID) async {
    var snapshot = await getUserDocumentSnapshot(userID);
    return snapshot.data.remove(_facebookInfoField);
  }

  /*
    Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userId': userId,
      'expires': expires.millisecondsSinceEpoch,
      'permissions': permissions,
      'declinedPermissions': declinedPermissions,
    };
  }
   */

  Future<void> setFacebookInfo(String userID, Map facebookId) async {
    return setFieldInUsers(userID, _facebookInfoField, facebookId);
  }

  Future<bool> checkFacebookInfo(String userID) async {
    var snapshot = await getUserDocumentSnapshot(userID);
    return snapshot.data.containsKey(_facebookInfoField) ? true : false;
  }

  Future<Map> getTwitterInfo(String userID) async {
    var snapshot = await getUserDocumentSnapshot(userID);
    return snapshot.data.remove(_twitterInfoField);
  }

  /*
  Map that is stored in database
  Map<String, dynamic> toMap() {
    return {
      'secret': secret,
      'token': token,
      'userId': userId,
      'username': username,
    };
  }
  */

  Future<void> setTwitterInfo(String userID, Map info) async {
    return setFieldInUsers(userID, _twitterInfoField, info);
  }

  Future<bool> checkTwitterInfo(String userID) async {
    var snapshot = await getUserDocumentSnapshot(userID);
    return snapshot.data.containsKey(_twitterInfoField) ? true : false;
  }

  Future<Map> getInstagramInfo(String userID) async {
    var snapshot = await getUserDocumentSnapshot(userID);
    return snapshot.data.remove(_instagramInfoField);
  }

  Future<bool> checkInstagramInfo(String userID) async {
    var snapshot = await getUserDocumentSnapshot(userID);
    return snapshot.data.containsKey(_instagramInfoField) ? true : false;
  }

/*
  Map<String, dynamic> toMap(){
    return {
      'token': access,
      'userId': id,
    };
  }
 */

  Future<void> setInstagramInfo(String userID, Map info) async {
    return setFieldInUsers(userID, _instagramInfoField, info);
  }

  Future<List> getFriendsIDs(String userID) async {
    List<String> friendIDs = new List();
    await _firestore.collection('relationships')
        .where('user1_id', isEqualTo: userID)
        .where('status', whereIn: [0, 2])
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
        friendIDs.add(doc.data['user2_id']);
      });
    });
    await _firestore.collection('relationships')
        .where('user2_id', isEqualTo: userID)
        .where('status', whereIn: [1, 2])
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
        friendIDs.add(doc.data['user1_id']);
      });
    });

    print(friendIDs.length);
    for(String id in friendIDs) {
      String name = await getUsername(id);
      print(name);
    }
    return friendIDs;
  }
}
