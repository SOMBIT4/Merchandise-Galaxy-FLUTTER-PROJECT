import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/login_pages.dart';
import 'package:merchendise_galaxy/pages/payment_page.dart';

import 'package:merchendise_galaxy/pages/product_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});
  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  List Screens = [
    ProductPage(),
    LoginPage(),
    PaymentPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _selectedIndex,
      backgroundColor: Colors.white,
      color: Colors.black,
      animationDuration: Duration(milliseconds: 250),
      items: [
        Icon(
          Icons.home,
          color: Colors.greenAccent,
        ),
        Icon(
          Icons.favorite,
          color: Colors.greenAccent,
        ),
        Icon(
          Icons.payment,
          color: Colors.greenAccent,
        ),
      ],
      onTap: (index) {
        setState(
          () {
            _selectedIndex = index;
          },
        );
      },
    );
  }
}
