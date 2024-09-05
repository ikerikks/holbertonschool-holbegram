import 'package:flutter/material.dart';
import 'package:holbegram/screens/pages/feed.dart';
import 'package:holbegram/widgets/bottom_nav.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Feed(),
      bottomNavigationBar: BottomNav(),
    );
  }
}
