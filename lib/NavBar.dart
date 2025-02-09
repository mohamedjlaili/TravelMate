
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Destination.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/Profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> _pages;

  int _currentIndex = 0;


  @override
  void initState() {
    _pages = [
      HomePage(),
      DetailScreen(),
       MyAccountScreen()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home),
          Icon(Icons.place),
          Icon(Icons.person)
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}