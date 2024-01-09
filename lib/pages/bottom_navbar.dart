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
    PaymentPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.grey.shade500,
      index: _selectedIndex,
      height: 65,
      color: Color.fromARGB(129, 165, 160, 160),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 350),
      items: [
        Icon(
          Icons.home,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Icon(
          Icons.favorite,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Icon(
          Icons.location_on,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        Icon(
          //onPressed: () {},
          //icon: Icon(
          Icons.person,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        //  ),
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
