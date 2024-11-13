import 'package:flutter/material.dart';
import 'package:margintop_solutions/cartView/cartPage.dart';
import 'package:margintop_solutions/views/homePageView/homePage.dart';
import 'package:margintop_solutions/views/homePageView/profilePage.dart';
import 'package:margintop_solutions/views/homePageView/settingsPage.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int _selectedIndex = 0;

  /******Handle bottom navigation*****/
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /******List of widgets according to bottom navigation selection******/
    final List<Widget> _screens = [
      const HomeViewPage(),
      Scaffold(
        body: CartPage(),
      ),
      const SettingsPage(),
      const ProfilePage(),
    ];
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
