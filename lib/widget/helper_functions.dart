import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> submitData(String name, String email, String profileUrl) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Check if user already exists in Firestore
  DocumentSnapshot userSnapshot = await users.doc(email).get();

  if (!userSnapshot.exists) {
    // If user does not exist, add new user
    return users
        .doc(email)
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
