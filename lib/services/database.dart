import 'package:cloud_firestore/cloud_firestore.dart';

// All default parameters are the defaults for a new user.

abstract class BaseDatabase {
  Future<bool> isNewUser(String userID);
  Future<void> setIsNewUser(String userID, {bool status});

  Future<String> getUsername(String userID);
  Future<void> setUsername(String userID, String username);

  Future<String> getFacebookId(String userID);
  Future<void> setFacebookId(String userID, String facebookId);

  Future<String> getTwitterId(String userID);
  Future<void> setTwitterId(String userID, String twitterId);
}

class Database implements BaseDatabase {
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionName = "users";
  final String _newUserStatusField = "is_new_user";
  final String _usernameField = "username";
  final String _facebookIdField = "facebook_id";
  final String _twitterIdField = "twitter_id";

  Future<void> setField(String userID, String fieldName, var value) {
    return _firestore.collection(_usersCollectionName).document(userID).setData({
      fieldName : value
    }, merge: true);
  }

  DocumentReference getUserDocumentRef(String userID) {
    return _firestore.collection(_usersCollectionName).document(userID);
  }

  Future <DocumentSnapshot> getDocumentSnapshot(String userID) {
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

  Future<String> getFacebookId(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
    return snapshot.data.remove(_facebookIdField);
  }

  Future<void> setFacebookId(String userID, String facebookId) async {
    return setField(userID, _facebookIdField, facebookId);
  }

  Future<String> getTwitterId(String userID) async {
    var snapshot = await getDocumentSnapshot(userID);
    return snapshot.data.remove(_twitterIdField);
  }

  Future<void> setTwitterId(String userID, String twitterId) async {
    return setField(userID, _twitterIdField, twitterId);
  }
}