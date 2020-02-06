import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseDatabase {
  Future<DocumentSnapshot> getUserData(String userID);
  Future<void> setField(String userID, String fieldName, String value);

  bool isNewUser(String userID);
  Future<void> setIsNewUser(String userID, bool status);

  String getFacebookID(String userID);
  Future<void> setFacebookID(String userID, String facebookID);

  String getInstagramID(String userID);
  Future<void> setInstagramID(String userID, String instagramID);

  String getTwitterID(String userID);
  Future<void> setTwitterID(String userID, String twitterID);
}

class Database implements BaseDatabase {
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionName = "users";
  final String _newUserStatusField = "is_new_user";
  final String _fbIDStatusField = "facebook_id";
  final String _igIDStatusField = "instagram_id";
  final String _twitterIDStatusField = "twitter_id";

  DocumentReference getUserDocumentRef(String userID) {
    return _firestore.collection(_usersCollectionName).document(userID);
  }

  @override
  Future <DocumentSnapshot> getUserData(String userID) {
    return getUserDocumentRef(userID).get();
  }

  @override
  Future<void> setField(String userID, String fieldName, String value) {
    return _firestore.collection(_usersCollectionName).document(userID).setData({
      fieldName : value
    });
  }

  @override
  bool isNewUser(String userID) {
    bool isNewUser = false;
    getUserData(userID).then((DocumentSnapshot ds) {
      isNewUser = ds.data.remove(_newUserStatusField);
    });
    return isNewUser;
  }

  @override
  Future<void> setIsNewUser(String userID, bool status) {
    return setField(userID, _newUserStatusField, status.toString());
  }

  @override
  String getFacebookID(String userID) {
    String fbID = "";
    getUserData(userID).then((DocumentSnapshot ds) {
      fbID = ds.data.remove(_fbIDStatusField);
    });
    return fbID;
  }

  @override
  Future<void> setFacebookID(String userID, String facebookID) {
    return setField(userID, _fbIDStatusField, facebookID);
  }

  @override
  String getInstagramID(String userID) {
    String igID = "";
    getUserData(userID).then((DocumentSnapshot ds) {
      igID = ds.data.remove(_igIDStatusField);
    });
    return igID;
  }

  @override
  Future<void> setInstagramID(String userID, String instagramID) {
    return setField(userID, _igIDStatusField, instagramID);
  }

  @override
  String getTwitterID(String userID) {
    String twitterID = "";
    getUserData(userID).then((DocumentSnapshot ds) {
      twitterID = ds.data.remove(_twitterIDStatusField);
    });
    return twitterID;
  }

  @override
  Future<void> setTwitterID(String userID, String twitterID) {
    return setField(userID, _twitterIDStatusField, twitterID);
  }
}