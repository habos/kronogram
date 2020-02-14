import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseDatabase {
  Future<bool> isNewUser(String userID);
  Future<void> setIsNewUser(String userID, bool status);
}

class Database implements BaseDatabase {
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionName = "users";
  final String _newUserStatusField = "is_new_user";

  Future<void> setField(String userID, String fieldName, String value) {
    return _firestore.collection(_usersCollectionName).document(userID).setData({
      fieldName : value
    });
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
  Future<void> setIsNewUser(String userID, bool status) {
    return setField(userID, _newUserStatusField, status.toString());
  }
}