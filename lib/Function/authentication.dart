import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final GoogleSignIn signIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await signIn.signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = await _auth.signInWithCredential(credential);
      print("signed in " + user.displayName);
      print(user.displayName);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void signOut() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
