// import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> submitData(String name, String email, String profileUrl) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Check if user already exists in Firestore
  DocumentSnapshot userSnapshot = await users.doc(email).get();
  var firebaseUser = await FirebaseAuth.instance.currentUser;

  if (!userSnapshot.exists) {
    // If user does not exist, add new user

    return users
        .doc(firebaseUser?.uid)
        .set({
          'name': name,
          'email': email,
          'profileUrl': profileUrl,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  } else {
    print("User already exists");
  }
}


// Future<void> userSetup(String email, String name) async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   FirebaseAuth auth = FirebaseAuth.instance;
//   //String uid = auth.currentUser!.uid.toString();
//   users.doc(firebaseUser?.uid)
//   .add({'email': email, 'name': name});
//   return;
//  }
// // class UserManagement {
// //   storeNewUser(user, context) async {
// //     var firebaseUser = await FirebaseAuth.instance.currentUser();
// //     FirebaseStorage.instance.se
// //         .collection('users')
// //         .document(firebaseUser.uid)
// //         .setData({'email': user.email, 'uid': user.uid})
// //         .then((value) => Navigator.push(
// //             context, MaterialPageRoute(builder: (context) => Home())))
// //         .catchError((e) {
// //           print(e);
// //         });
// //   }
// // }

// Future<bool> isFirstTime(GoogleSignInAccount googleUser) async {
//   // Get the user's unique ID
//   String uid = googleUser.id;

//   // Get a reference to the user's document in Firestore
//   DocumentReference userDocRef =
//       FirebaseFirestore.instance.collection('users').doc(uid);

//   // Check if the document exists
//   DocumentSnapshot userDocSnapshot = await userDocRef.get();

//   // If the document does not exist, the user is signing in for the first time
//   if (!userDocSnapshot.exists) {
//     return true;
//   } else {
//     return false;
//   }
// }
