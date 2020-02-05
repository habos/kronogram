import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseDatabase {
  Future<DocumentSnapshot> getUserData(String userID);
  
  bool isNewUser(String userID);
}

class Database implements BaseDatabase {
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionName = "users";
  
  @override
  Future <DocumentSnapshot> getUserData(String userID) {
    _firestore.collection(_usersCollectionName).document(userID).get();
  }
  
  @override
  bool isNewUser(String userID) {
    bool isNewUser = false;
    _firestore.collection(_usersCollectionName).document(userID).get().then((DocumentSnapshot ds) {
      isNewUser = ds.data.remove("is_new_user");
    });
    return isNewUser;
  }
}