import 'package:flutter/material.dart';
import 'package:flutter_app/NavBar.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
          },
          child: const Text(
            "Back",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        title: const Text(
          "Thailand , Bali",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Image with Title
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/tailand.jpg",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.remove_red_eye, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("27K", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.star, size: 16, color: Colors.orange),
                    SizedBox(width: 4),
                    Text("4.0", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("342", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.favorite_border, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text("6473", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Comments Section
            const Text(
              "Comments : ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Comment 1
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/user1.jpg'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "anthoni Bugantara",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "5 hours ago",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      const Text("it was a wonderful journey and the food is delicious."),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Reply",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Comment 2
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/user2.jpg'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "jude mafiosa",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "1 hour ago",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      const Text("this experience is so wonderful, the hotel is nice and the pool is clean."),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Reply",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Add booking logic here
              },
              child: const Text(
                "Book Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write a comment",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 