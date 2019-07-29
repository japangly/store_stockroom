import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Authentication {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    try {
      FirebaseUser firebaseUser = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return firebaseUser.uid;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
