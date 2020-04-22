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
  final String _relationshipsCollectionName = "relationships";
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

  /* relationship status codes
  1 : user1 follows user2
  2 : user2 follows user1
  3 : both users follow each other

  0 -> no relationship
   */

  /// get a list of IDs of users that userID follows
  Future<List> getFollowingIDs(String userID) async {
    print('getting following');
    List<String> friendIDs = new List();
    await _firestore.collection(_relationshipsCollectionName)
        .where('user1_id', isEqualTo: userID)
        .where('status', whereIn: [1, 3])
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
        friendIDs.add(doc.data['user2_id']);
      });
    });
    await _firestore.collection(_relationshipsCollectionName)
        .where('user2_id', isEqualTo: userID)
        .where('status', whereIn: [2, 3])
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

  Future<List> getFollowersIDs(String userID) async {
    print('getting followers ...');
    List<String> friendIDs = new List();
    await _firestore.collection(_relationshipsCollectionName)
        .where('user1_id', isEqualTo: userID)
        .where('status', whereIn: [2, 3])
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
        friendIDs.add(doc.data['user2_id']);
      });
    });
    await _firestore.collection(_relationshipsCollectionName)
        .where('user2_id', isEqualTo: userID)
        .where('status', whereIn: [1, 3])
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
        friendIDs.add(doc.data['user1_id']);
      });
    });

    return friendIDs;
  }

  Future<List> getFollowersIDsAndStatus(String userID) async {
    print('getting followers ...');
    List<Map<String,dynamic>> friendIDs = new List();
    await _firestore.collection(_relationshipsCollectionName)
        .where('user1_id', isEqualTo: userID)
        .where('status', whereIn: [2, 3])
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
        friendIDs.add({'userID':doc.data['user2_id'], 'status': doc.data['status']});
      });
    });
    await _firestore.collection(_relationshipsCollectionName)
        .where('user2_id', isEqualTo: userID)
        .where('status', whereIn: [1, 3])
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) {
        print(doc.data);
        friendIDs.add({'userID':doc.data['user1_id'], 'status': doc.data['status']});
      });
    });

    return friendIDs;
  }

  /// userID follows friendID and adds/updates relationship in database
  Future<void> followFriend(String userID, String friendID) async {
    Map users = _orderUsersRelationship(userID, friendID);
    String low = users['low'];
    String user1 = users['user1'];
    String user2 = users['user2'];
    Map exists = await relationshipExists(user1, user2);
    int status = exists['status'];
    String relationshipID = exists['relationshipID'];

    //a relationship already exists so friendID must already follow userID
    //set the code to 3 so they both follow each other
    if(status > 0) await updateRelationship(relationshipID, 3);
    else {
      if(low == 'user') await createRelationship(user1, user2, 1);
      else await createRelationship(user1, user2, 2);
    }

  }

  /// checks if existing relationship between two users
  Future<Map<String, dynamic>> relationshipExists(String user1, String user2) async {
    int exists;
    String relationshipId;
    await _firestore.collection(_relationshipsCollectionName)
        .where('user1_id',isEqualTo: user1)
        .where('user2_id', isEqualTo: user2)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
          if(snapshot.documents.length > 0)  {
            print(snapshot.documents[0].documentID);
            exists = snapshot.documents[0].data['status'];
            relationshipId = snapshot.documents[0].documentID;
          }
          else {
            exists = 0;
            relationshipId = null;
          }
    });

    print('status: $exists, relationshipID: $relationshipId');

    return {'status' : exists, 'relationshipID' : relationshipId};
  }

  /// userID unfollows friendID and removes/updates relationship in database
  Future<void> unfollowFriend(String userID, String friendID) async {
    print('unfollowing ...');
    Map users = _orderUsersRelationship(userID, friendID);
    String low = users['low'];
    String user1 = users['user1'];
    String user2 = users['user2'];
    Map exists = await relationshipExists(user1, user2);
    int status = exists['status'];
    String relationshipID = exists['relationshipID'];

    if(status == 0) {
      print('error ... no relationship found');
      return;
    }

    if(low == 'user') {
      if(status == 3) await updateRelationship(relationshipID, 2);
      else await removeRelationship(relationshipID);
    }
    else {
      if(status == 3) await updateRelationship(relationshipID, 1);
      else await removeRelationship(relationshipID);
    }

  }

  /// create new relationship in db
  Future<void> createRelationship(String user1, String user2, int code) async {
    print('creating ...');
    return _firestore.collection(_relationshipsCollectionName).document()
        .setData({'user1_id' : user1, 'user2_id' : user2, 'status' : code});
  }

  /// remove relationship from db
  Future<void> removeRelationship(String relationshipId) async {
    print('removing ...');
    return _firestore.collection(_relationshipsCollectionName)
        .document(relationshipId)
        .delete();
  }

  Future<void> updateRelationship(String relationshipID, int code) async {
    print('updating ...');
    return _firestore.collection(_relationshipsCollectionName)
        .document(relationshipID)
        .updateData({'status':code});
  }

  /// returns a map of id1 and id2, where id1 < id2
  Map<String, String> _orderUsersRelationship(String userId, String friendId) {
    int result = userId.compareTo(friendId);
    if(result < 0) {
      return {'low' : 'user', 'user1' : userId, 'user2' : friendId};
    }
    else {
      return {'low' : 'friend', 'user1' : friendId, 'user2' : userId};
    }
  }

}
