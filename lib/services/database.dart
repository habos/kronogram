import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseDatabase {
  Future<DocumentSnapshot> getUserData(String userID);

  bool isNewUser(String userID);
  Future<void> setIsNewUser(String userID, bool status);
}

class Database implements BaseDatabase {
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionName = "users";
  final String _newUserStatusField = "is_new_user";

  @override
  Future <DocumentSnapshot> getUserData(String userID) {
    _firestore.collection(_usersCollectionName).document(userID).get();
  }

  @override
  bool isNewUser(String userID) {
    bool isNewUser = false;
    _firestore.collection(_usersCollectionName).document(userID).get().then((DocumentSnapshot ds) {
      isNewUser = ds.data.remove(_newUserStatusField);
    });
    return isNewUser;
  }

  @override
  Future<void> setIsNewUser(String userID, bool status) {
    return _firestore.collection(_usersCollectionName).document(userID).setData({
      _newUserStatusField : status.toString()
    });
  }


}