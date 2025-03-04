import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../screens/pages/feed.dart';
import '../screens/pages/search.dart';
import '../screens/pages/add_image.dart';
import '../screens/pages/favorite.dart';
import '../screens/pages/profile.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const Feed(),
          // const Search(),
          // const AddImage(),
          // const Favorite(),
          // const Profile(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home', style: TextStyle(fontSize: 25, fontFamily: 'Billabong')),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search', style: TextStyle(fontSize: 25, fontFamily: 'Billabong')),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.add),
            title: const Text('Add', style: TextStyle(fontSize: 25, fontFamily: 'Billabong')),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text('Favorite', style: TextStyle(fontSize: 25, fontFamily: 'Billabong')),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile', style: TextStyle(fontSize: 25, fontFamily: 'Billabong')),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
