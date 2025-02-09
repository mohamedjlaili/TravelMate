import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Toast.dart';
import 'package:flutter_app/formContainer.dart';
import 'package:flutter_app/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for our text fields.
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // Use separate controllers for password and confirm password.
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Dispose controllers when not needed.
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double toul = MediaQuery.of(context).size.height;
    double orth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        // Use SingleChildScrollView to prevent overflow when keyboard is visible.
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: SizedBox(
                  height: toul * .50,
                  width: orth,
                  child: Image.asset(
                    "assets/jmall fi sahra.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FormContainerWidget(
                  controller: _usernameController,
                  hintText: "User Name",
                  isPasswordField: false,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
              ),
              const SizedBox(height: 12),
              // Confirm Password Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FormContainerWidget(
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  isPasswordField: true,
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: _signUp,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 41, 245),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 5, height: 50),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        " Login ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 51, 136, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    // Retrieve text from controllers
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Verify that all fields are filled
    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showToast(message: "Veuillez remplir tous les champs.");
      return;
    }

    // Check if password and confirm password match
    if (password != confirmPassword) {
      showToast(message: "Les mots de passe ne correspondent pas.");
      return;
    }

    // Check password length
    if (password.length < 6) {
      showToast(message: "Le mot de passe doit contenir au moins 6 caractères.");
      return;
    }

    try {
      // Create the user using Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        // Add additional user information to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        showToast(message: "Utilisateur créé avec succès");
        // Navigate to the Login page (or another page) after sign up
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific errors
      showToast(message: e.message ?? "Une erreur est survenue.");
    } catch (e) {
      // Handle any other errors
      showToast(message: "Erreur : ${e.toString()}");
    }
  }
}
