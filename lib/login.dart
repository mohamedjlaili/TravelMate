import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/HomePage.dart'; // Or your MainPage if that's what you're using.
import 'package:flutter_app/NavBar.dart';
import 'package:flutter_app/Toast.dart';
import 'package:flutter_app/formContainer.dart';
import 'Register.dart'; // This should contain your SignUpPage widget.

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for the email and password fields.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dispose of the controllers when the widget is removed.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Build the login page UI.
  @override
  Widget build(BuildContext context) {
    double toul = MediaQuery.of(context).size.height;
    double orth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top image with rounded bottom corners.
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: SizedBox(
                height: toul * .50,
                width: orth,
                child: Image.asset("assets/bhar.jpeg", fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            // Email input field.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
            ),
            const SizedBox(height: 20),
            // Password input field.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
            ),
            const SizedBox(height: 10),
            // Login button.
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: _signIn,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 41, 245),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
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
            const SizedBox(height: 15),
            // Navigation to the Sign Up page.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 51, 136, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // The _signIn method connects to Firebase and attempts to sign in the user.
  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Check that both fields are filled.
    if (email.isEmpty || password.isEmpty) {
      showToast(message: "Veuillez remplir tous les champs.");
      return;
    }

    try {
      // Attempt to sign in using Firebase Authentication.
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // If sign in succeeds, navigate to the main page.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // If there is an error from Firebase, display it.
      showToast(message: e.message ?? "Erreur lors de la connexion.");
    } catch (e) {
      // For any other error, display a generic message.
      showToast(message: "Erreur: ${e.toString()}");
    }
  }
}
