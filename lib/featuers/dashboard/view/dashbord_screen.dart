import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/styling/app_color.dart';

import '../../wash_status/view/wash_status_screen.dart';

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
    WashStatusScreen(),
    Center(child: Text('Notification', style: TextStyle(fontSize: 30))),
    Center(child: Text('Profile', style: TextStyle(fontSize: 30))),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _currentIndex == 0 ? Icon(Icons.home, color: Colors.white) : Icon(Icons.home_outlined, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1 ? Icon(Icons.star, color: Colors.white) : Icon(Icons.star_border, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2 ? Icon(Icons.add, color: Colors.white) : Icon(Icons.add_outlined, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 3 ? Icon(Icons.notifications, color: Colors.white) : Icon(Icons.notifications_outlined, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 4 ? Icon(Icons.person, color: Colors.white) : Icon(Icons.person_outline, color: Colors.white),
            label: '', // Empty label
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: AppColor.blue,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        elevation: 6,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        onPressed: () {
Get.toNamed(RouteStrings.washStatusScreen);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}