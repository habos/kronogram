import 'package:cloud_firestore/cloud_firestore.dart';

// All default parameters are the defaults for a new user.

abstract class BaseDatabase {
  Future<bool> isNewUser(String userID);
  Future<void> setIsNewUser(String userID, {bool status});

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
  final String _newUserStatusField = "is_new_user";
  final String _usernameField = "username";
  final String _facebookInfoField = "facebook_info";
  final String _twitterInfoField = "twitter_info";
  final String _instagramInfoField = "instagram_info";

  Future<void> setField(String userID, String fieldName, var value) {
    return _firestore
        .collection(_usersCollectionName)
        .document(userID)
        .setData({fieldName: value}, merge: true);
  }

  DocumentReference getUserDocumentRef(String userID) {
    return _firestore.collection(_usersCollectionName).document(userID);
  }

  Future<DocumentSnapshot> getDocumentSnapshot(String userID) {
    return getUserDocumentRef(userID).get();
  }

  @override
  Future<bool> isNewUser(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
    return snapshot.data.remove(_newUserStatusField);
  }

  @override
  Future<void> setIsNewUser(String userID, {bool status = true}) {
    return setField(userID, _newUserStatusField, status);
  }

  Future<String> getUsername(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
    return snapshot.data.remove(_usernameField);
  }

  Future<void> setUsername(String userID, String username) async {
    return setField(userID, _usernameField, username);
  }

  Future<Map> getFacebookInfo(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
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
    return setField(userID, _facebookInfoField, facebookId);
  }

  Future<bool> checkFacebookInfo(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
    return snapshot.data.containsKey(_facebookInfoField) ?  true : false;
  }

  Future<Map> getTwitterInfo(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
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
    return setField(userID, _twitterInfoField, info);
  }

  Future<bool> checkTwitterInfo(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
    return snapshot.data.containsKey(_twitterInfoField) ?  true : false;
  }

  Future<Map> getInstagramInfo(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
    return snapshot.data.remove(_instagramInfoField);
  }

  Future<bool> checkInstagramInfo(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
    return snapshot.data.containsKey(_instagramInfoField) ?  true : false;
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
    return setField(userID, _instagramInfoField, info);
  }
}
