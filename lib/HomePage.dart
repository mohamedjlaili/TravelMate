import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/Destination.dart';
import 'package:flutter_app/Profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _addDestinationToFavorites(String name, String image) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    try {
      await userDoc.update({
        'favorites': FieldValue.arrayUnion([
          {'name': name, 'image': image}
        ])
      });
    } catch (e) {
      debugPrint("Error adding to favorites: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.place, color: Colors.black),
            const SizedBox(width: 5),
            const Text(
              'Feed',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 41, 245),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Explore the\n',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Beautiful ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'world !',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/tailand.jpg',
                title: 'Thailand, Bali',
                price: '\$699',
              ),
              const SizedBox(height: 16),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/italia.jpg',
                title: 'Sicilia, Italy',
                price: '\$599',
              ),
              const SizedBox(height: 16),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/tokyo.jpeg',
                title: 'Tokyo, Japan',
                price: '\$899',
              ),
              const SizedBox(height: 16),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/New York City.jpg',
                title: 'New York, America',
                price: '\$1099',
              ),
              const SizedBox(height: 16),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/Barcelona Spain.jpg',
                title: 'Barcelona, Spain',
                price: '\$899',
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTravelCard({
    required BuildContext context,
    required String imagePath,
    required String title,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              imagePath: imagePath,
              price: price,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            price,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _addDestinationToFavorites(title, imagePath);
                        },
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
