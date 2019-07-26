import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authenticate {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String> register({@required String email, @required String password}) async {
    FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<bool> login(
      {@required String email, @required String password}) async {
    FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (user.uid != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
