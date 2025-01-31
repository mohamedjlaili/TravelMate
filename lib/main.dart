import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Destination.dart';
import 'package:flutter_app/EditProfile.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/Profile.dart';
import 'package:flutter_app/splash.dart';
import 'NavBar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
