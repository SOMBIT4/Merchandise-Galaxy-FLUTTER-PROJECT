import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/add_items.dart/add_item.dart';
import 'package:merchendise_galaxy/pages/product/bottom_navbar.dart';
import 'package:merchendise_galaxy/pages/product/product_page.dart';
import 'package:merchendise_galaxy/pages/profile/profile_info.dart';
//import 'package:merchendise_galaxy/pages/profile/profile_update.dart';
import 'package:merchendise_galaxy/pages/login_reg/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:merchendise_galaxy/pages/login_reg/splassh_screen.dart';
import 'package:merchendise_galaxy/pages/profile/update_profile.dart';
import 'pages/login_reg/login_pages.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyBviwGHwBeUELJ-ucYG4HWuk9lEnddS7SI",
            appId: "1:887917938524:android:c9e9e06d62919b8de6a399",
            messagingSenderId: "887917938524",
            projectId: "merchendise-galaxy",
            storageBucket: "merchendise-galaxy.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
      routes: {
        '/login_page': (context) => LoginPage(),
        '/product_page': (context) => const ProductPage(),
        '/register_page': (context) => registerPage(),
        '/buttomNavigation': (context) => const BottomNavigation(),
        '/updateProfile': (context) => const UpdateProfileScreen(),
        '/profileInfo': (context) => const ProfileInfo(),
        '/addItem': (context) => const AddItem(),
      },
    ),
  );
}
