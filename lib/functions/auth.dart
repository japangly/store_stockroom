import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Authentication {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn({
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

  Future<bool> resetPassword({
    @required String email,
  }) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changePassword({
    @required String newPassword,
  }) async {
    try {
      FirebaseUser firebaseUser = await firebaseAuth.currentUser();
      firebaseUser.updatePassword(newPassword);
      return true;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
