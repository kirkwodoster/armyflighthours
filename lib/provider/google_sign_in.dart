import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  String userCheck = '';

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // print('access token: ');
      // print(googleAuth.accessToken);
      // print(googleAuth.idToken);
      // print('idToken:');

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final uid = userCredential.user!.uid;
      print(uid);
      // Check if document exists
      final snapShot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // If document doesn't exist, add it

      if (!snapShot.exists) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': googleUser.displayName,
          'email': googleUser.email,
        });
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
