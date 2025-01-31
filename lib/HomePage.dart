import 'package:flutter/material.dart';
import 'package:flutter_app/Destination.dart';
import 'package:flutter_app/Profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  get onTap => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.place, color: Colors.black),
            SizedBox(width: 5),
            Text(
              'Feed',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 41, 245),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              
              // Header Text
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Explore the\n',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
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
              SizedBox(height: 20),
              
              // Travel Cards
              _buildTravelCard(
                context: context,
                imagePath: 'assets/tailand.jpg',
                title: 'Tailand , Bali',
                price: '\$699',
              ),
              SizedBox(height: 16),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/italia.jpg',
                title: 'Secilia , Italia',
                price: '\$599',
              ),
              SizedBox(height: 16),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/tokyo.jpeg',
                title: 'Tokyo , Japan',
                price: '\$899',
              ),
              SizedBox(height: 16),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/New York City.jpg',
                title: 'New York  , America',
                price: '\$1099',
              ),
              SizedBox(height: 16),
              _buildTravelCard(
                context: context,
                imagePath: 'assets/Barcelona Spain.jpg',
                title: 'Barcelona  , Spain',
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
             
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16),
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
                  padding: EdgeInsets.all(16),
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            price,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                       onTap : () {
                            Navigator.push( context, 
                            MaterialPageRoute( builder: (context) => MyAccountScreen ()
                                ),
                             );
                           },
                     child:  Icon(Icons.favorite_border, color: Colors.white),
                      )
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


    
