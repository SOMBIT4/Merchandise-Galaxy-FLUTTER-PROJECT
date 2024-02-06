import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchendise_galaxy/pages/login_reg/login_pages.dart';
import 'package:merchendise_galaxy/pages/product/bottom_navbar.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen>
    with SingleTickerProviderStateMixin {
  //diseapear upper and bottom bars
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 4), () {
      bool isLoggedIn = false;
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) isLoggedIn = true;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => isLoggedIn ? const BottomNavigation() : LoginPage()));
    });
  }

  //apear bars again
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'lib/images/logo1.png',
                height: 350,
                width: 350,
              ),
              //text
              Container(
                padding: const EdgeInsets.only(left: 5, top: 40),
                child: Text(
                  'Merchandise',
                  style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Fontmain',
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //text
              Container(
                padding: const EdgeInsets.only(left: 140, top: 10),
                child: Text(
                  'Galaxy',
                  style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Fontmain',
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
