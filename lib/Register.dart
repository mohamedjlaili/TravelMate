
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


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double toul = MediaQuery.of(context).size.height;
    double orth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(borderRadius: BorderRadius.only(
               bottomLeft: Radius.circular(40),
               bottomRight: Radius.circular(40),

            ),
              

            child: SizedBox(
        height: toul*.50,
        width : orth,  
        child: Container(
          height: toul*.30,
          width: orth,
          
        child: Image.asset("assets/jmall fi sahra.jpeg" ,fit:BoxFit.cover ))),
       
        ),
        
            const SizedBox(
            height: 20,
            ),
         Padding(
              padding: const EdgeInsets.only(left : 15 , right : 15),
           child:  FormContainerWidget(
              controller: _usernameController,
              hintText: "User Name",
              isPasswordField: false,
            ),
         ),
            const SizedBox(
              height: 12,
            ),
             Padding(
              padding: const EdgeInsets.only(left : 15 , right : 15),
              child:  FormContainerWidget(
              controller: _emailController,
              hintText: "Email",
              isPasswordField: false,
            ),
             ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left : 15 , right : 15),

             child:  FormContainerWidget(
              controller: _passwordController,
              hintText: "Password",
              isPasswordField: true,
            ),
            ),
            const SizedBox(
              height: 2,
            ),
             const SizedBox(
              height: 12,
            ),
             Padding(
              padding: const EdgeInsets.only(left : 15 , right : 15),
              child:  FormContainerWidget(
              controller: _passwordController,
              hintText: " Confirm Password",
              isPasswordField: true,
            ),
             ),
            const SizedBox(
              height: 22,
            ),



          Padding(
              padding: const EdgeInsets.all(15.0),
            child:  GestureDetector(
              onTap: _signUp,
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 41, 245),
                  borderRadius: BorderRadius.circular(20),
                ),
                
              




                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25 ,
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
                const SizedBox(
                  width: 5,
                  height: 50,
                ),
                 Padding(
              padding: const EdgeInsets.all(15.0),
               child:  GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
    );
  }

  void _signUp() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Vérifier si tous les champs sont remplis
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      showToast(message: "Veuillez remplir tous les champs.");
      return;
    }

   
    // Vérifier si le mot de passe est suffisamment long
    if (password.length < 6) {
      showToast(
          message: "Le mot de passe doit contenir au moins 6 caractères.");
      return;
    }

  }
}
