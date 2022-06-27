import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_market/constants.dart';

import 'package:global_market/models/users.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
  FirebaseFirestore.instance.collection(kUsers);

  Future<void> addUserToFireStore(Users userModel) async {
    return await _userCollectionRef.doc(userModel.userId).
    set(userModel.toJson());
  }

  // void saveUser(UserCredential user) async {
  //   await FireStoreUser().addUserToFireStore(Users(
  //     userId: user.user.uid,
  //     email: user.user.email,
  //     name: name == null ? user.user.displayName : name,
  //     pic: '',
  //   ));
  // }




}