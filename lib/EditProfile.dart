import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Profile.dart'; // This should point to your profile (MyAccountScreen).

void main() {
  // Ensure Firebase is initialized before running the app.
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers for the text fields.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Load the current user's profile data when the widget initializes.
  @override
  void initState() {
    super.initState();
    _loadCurrentProfile();
  }

  Future<void> _loadCurrentProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Fetch the user's document from Firestore.
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists && doc.data() != null) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['username'] ?? user.displayName ?? "";
          _emailController.text = data['email'] ?? user.email ?? "";
        });
      }
    }
  }

  // This function saves the new profile data to Firestore.
  Future<void> _saveChanges() async {
    final String newName = _nameController.text.trim();
    final String newEmail = _emailController.text.trim();

    if (newName.isEmpty || newEmail.isEmpty) {
      // Optionally, show an error message (e.g., using a Toast or Snackbar).
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Update the Firestore document for the user.
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'username': newName,
        'email': newEmail,
      });

      // Optionally, update the Firebase Authentication profile.
      await user.updateDisplayName(newName);
      // Note: Updating the email in FirebaseAuth requires re-authentication and is more involved.

      // After saving, navigate back to the Profile page.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyAccountScreen()),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 41, 245),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAccountScreen()),
            );
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 41, 245),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Full Name TextField
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: 'Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Email Address TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Save Changes Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 83, 250),
                        Color.fromARGB(255, 1, 10, 255)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
