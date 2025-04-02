import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../styling/app_color.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Home', style: TextStyle(fontSize: 30))),
    Center(child: Text('Reward', style: TextStyle(fontSize: 30))),
    Center(child: Text('Main', style: TextStyle(fontSize: 30))),
    Center(child: Text('Notification', style: TextStyle(fontSize: 30))),
    Center(child: Text('Profile', style: TextStyle(fontSize: 30))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              AppColor.c001B51,
              AppColor.c0D100C,
            ],
          ),
        ),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60.0,
        items: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home, size: 30, color: AppColor.c001B51),
              if (_currentIndex != 0)
                Text('Home', style: TextStyle(color: AppColor.c001B51)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 30, color: AppColor.c001B51),
              if (_currentIndex != 1)
                Text('Search', style: TextStyle(color: AppColor.c001B51)),
            ],
          ),
          // Center Icon
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: IconButton(
              icon: Icon(Icons.add, size: 40, color: AppColor.white),
              onPressed: () {
                // Handle center button press
                // You can navigate to a new screen or perform an action
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.notifications, size: 30, color: AppColor.c001B51),
              if (_currentIndex != 3)
                Text('Notification', style: TextStyle(color: AppColor.c001B51)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 30, color: AppColor.c001B51),
              if (_currentIndex != 4)
                Text('Profile', style: TextStyle(color: AppColor.c001B51)),
            ],
          ),
        ],
        color: AppColor.cF6F7FF,
        buttonBackgroundColor: AppColor.c001B51, // Change this to your desired color
        backgroundColor: AppColor.c0D100C,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          if (index != 2) { // Prevent changing index when center button is tapped
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}