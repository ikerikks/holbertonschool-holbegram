import 'package:flutter/material.dart';
import 'package:holbegram/utils/posts.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong', // Assuming 'Billabong' is a custom font
                fontSize: 24.0,
              ),
            ),
            // Add your logo here
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add your search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add your notifications functionality here
            },
          ),
        ],
      ),
      body: Posts(), // Assuming Posts is the widget you're going to create later
    );
  }
}
