import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/app_colors.dart';
import 'bottom_nav_pages/cart.dart';
import 'bottom_nav_pages/home.dart';
import 'bottom_nav_pages/favourite.dart';
import 'bottom_nav_pages/profile.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [Home(), Favourite(), Cart(), Profile()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "E-Commerce",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35.sp,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: AppColors.deepOrange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
        currentIndex: _currentIndex,
        selectedLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: "Home",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 35),
            label: "Favourites",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 35),
            label: "Cart",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 35),
            label: "Profile",
            backgroundColor: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
