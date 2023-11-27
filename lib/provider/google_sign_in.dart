import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_verify_email/widget/helper_functions.dart';
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

      // Check if user is already authenticated
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // If user is not authenticated, authenticate user and add user to Firestore
        await FirebaseAuth.instance.signInWithCredential(credential);
        await submitData(googleUser.displayName ?? 'Unknown',
            googleUser.email ?? 'Unknown', googleUser.photoUrl ?? 'Unknown');
        userCheck = 'NewUser';
        print(userCheck);
        //String monthStatus = await checkMonthKey(user.id);
        //print(monthStatus);
        //await userHasMonthEntry(user.id);
        //await AlertDialogProvider.showAlertDialog(context);
      } else {
        userCheck = 'returnUser';
        print(userCheck);
        print("User is already authenticated");
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
