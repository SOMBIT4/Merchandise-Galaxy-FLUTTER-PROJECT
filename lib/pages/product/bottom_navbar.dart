import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/cart/my_cart.dart';

import 'package:merchendise_galaxy/pages/product/product_page.dart';
import 'package:merchendise_galaxy/pages/profile/profile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});
  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late ProductPage productPage;
  late ProfileScreen profileScreen;
  late CartView cartView;

  void initState() {
    productPage = ProductPage();
    profileScreen = ProfileScreen();
    cartView = CartView();
    pages = [productPage, cartView, profileScreen];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.grey.shade500,
          height: 65,
          color: Color.fromARGB(129, 165, 160, 160),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 350),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home_outlined,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Icon(
              Icons.shopping_cart_outlined,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            // Icon(
            //   Icons.wallet_outlined,
            //   color: Colors.white,
            // ),
            Icon(
              Icons.person_outline,
              color: Color.fromARGB(255, 0, 0, 0),
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}
