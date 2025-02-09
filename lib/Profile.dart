import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/EditProfile.dart';
import 'package:flutter_app/NavBar.dart';
import 'package:flutter_app/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase (if not already done):
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAccountScreen(),
    );
  }
}

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  // Variables for profile data.
  String? username;
  String? email;
  // Favorites list loaded from Firestore.
  List<Map<String, String>> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadFavorites();
  }

  // Load the user profile (name and email).
  Future<void> _loadProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists && doc.data() != null) {
        setState(() {
          username = (doc.data() as Map<String, dynamic>)['username'] ?? user.displayName;
          email = (doc.data() as Map<String, dynamic>)['email'] ?? user.email;
        });
      } else {
        setState(() {
          username = user.displayName ?? "No Name";
          email = user.email;
        });
      }
    }
  }

  // Load the favorites array from the user's Firestore document.
  Future<void> _loadFavorites() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('favorites')) {
          List<dynamic> favList = data['favorites'];
          setState(() {
            favorites = favList.map((item) => {
              'name': item['name'] as String,
              'image': item['image'] as String,
            }).toList();
          });
        }
      }
    }
  }

  // Remove a destination from favorites (both locally and in Firestore).
  Future<void> removeDestination(int index) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      Map<String, String> destination = favorites[index];
      await userDoc.update({
        'favorites': FieldValue.arrayRemove([destination])
      });
      // Reload favorites to update the UI.
      _loadFavorites();
    }
  }

  // Log out the user.
  Future<void> _logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } catch (e) {
      debugPrint("Error logging out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a loader if profile data is still loading.
    bool isLoading = username == null || email == null;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          child: const Text(
            "Back",
            style: TextStyle(color: Color.fromARGB(255, 0, 41, 245)),
          ),
        ),
        title: const Text(
          "My Account",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 41, 245),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _logOut,
            child: const Text(
              "Logout",
              style: TextStyle(color: Color.fromARGB(255, 0, 41, 245)),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                    username ?? "",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 4),
            isLoading
                ? const SizedBox()
                : Text(
                    email ?? "",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                "Edit Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 13, 255),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My favorite destinations:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            favorites.isEmpty
                ? const Text("No favorite destinations yet.")
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                favorites[index]['image']!,
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                favorites[index]['name']!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeDestination(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
