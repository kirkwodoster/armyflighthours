import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_verify_email/main.dart';
import 'package:firebase_auth_verify_email/page/on_board.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_verify_email/widget/login_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email!;

    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
          //title: Text('Home'),
          ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              email.toString(),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            // Text(
            //   //user.email!,
            //   //style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.arrow_back, size: 32),
              label: Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                // initialOnboardData();
                // totalHours();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                      (Route<dynamic> route) => false,
                );


              },),
            // CheckUserMonth()
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final User user = FirebaseAuth.instance.currentUser!;
  String userEmail = 'email: ${FirebaseAuth.instance.currentUser!.email}';
  String? email = FirebaseAuth.instance.currentUser?.email!;

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
          ])));

  Widget buildHeader(BuildContext context) => Material(
        color: Colors.blue.shade700,
        child: InkWell(
          onTap: () {
            // close navigation drawer before
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Sarah Abs',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                Text(
                  email!,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16, // vertical spacing
          children: [
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () {}
                //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => const HomePage(),
                // )),
                ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Account'),
              onTap: () {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => const FavouritesPage(),
                // ));

                /// In case no Scaffold.drawer is added on 'FavouritesPage'
                // // close navigation drawer before
                // Navigator.pop(context);

                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const FavouritesPage(),
                // ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.airplanemode_active),
              title: const Text('Hours'),
              onTap: () {},
            ),
            //const Divider(color: Colors.black54),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Statistics'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
      );
}




//
// Future<User?> _signIn() async {
//   final googleSignIn = GoogleSignIn();
//   try {
//     GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//     GoogleSignInAuthentication gSA = await googleSignInAccount!.authentication;
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: gSA.accessToken,
//       idToken: gSA.idToken,
//     );
//     UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
//     if (authResult.additionalUserInfo?.isNewUser ?? false) {
//       // User logging in for the first time
//       // Redirect user to tutorial
//     } else {
//       // User has already logged in before.
//       // Show user profile
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }







// class CheckUserMonth extends StatefulWidget {
//   @override
//   _CheckUserMonthState createState() => _CheckUserMonthState();
// }
//
// class _CheckUserMonthState extends State<CheckUserMonth> {
//   String? selectedMonth;
//   final User user = FirebaseAuth.instance.currentUser!;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future:
//           FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//
//           Map<String, dynamic>? data =
//               snapshot.data!.data() as Map<String, dynamic>?;
//           if (data?.containsKey('Birth Month') != true) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => OnBoardingScreen()));
//             });
//             return SizedBox.shrink(); // return an empty widget
//           }
//         }
//
//         return SizedBox.shrink();
//       },
//     );
//   }
// }
