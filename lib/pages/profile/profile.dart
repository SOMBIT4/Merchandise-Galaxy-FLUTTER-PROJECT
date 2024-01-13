//import 'dart:js';

//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//import 'package:merchendise_galaxy/pages/login_pages.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  //docid
  List<String> docids = [];
//get doc id
  Future getdocid() async {
    await FirebaseFirestore.instance.collection('user').get().then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              print(element.reference);
              docids.add(element.reference.id);
            },
          ),
        );
  }

  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(AppAssets.profileImg),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.whiteColor),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.data == null) {
                    return const Text("No data");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    //return Text("Full Name: ${data['name']}");
                    return Container(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text('${data['Name']}',
                              style: Theme.of(context).textTheme.headline4),
                          const SizedBox(height: 20),
                          Text('${data['Email']}',
                              style: Theme.of(context).textTheme.bodyText2),
                          const SizedBox(height: 40),
                        ],
                      ),
                    );
                  }
                  return const Text("loading");
                },
              ),
              // const SizedBox(height: 20),
              // Text('Name', style: Theme.of(context).textTheme.headline4),
              // const SizedBox(height: 20),
              // Text('Email', style: Theme.of(context).textTheme.bodyText2),
              // const SizedBox(height: 40),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/updateProfile'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.whiteColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Edit Profile',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 30),

              /// -- MENU

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/profileInfo'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.whiteColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Profile Imformation',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 30),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.whiteColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('LOG OUT',
                      style:
                          TextStyle(color: Color.fromARGB(255, 212, 26, 26))),
                ),
              ),

              /* ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                     Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () => AuthenticationRepository.instance.logout(),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                    );
                  }),*/
            ],
          ),
        ),
      ),
    );
  }

  logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, '/login_page', (route) => false);
    } catch (e) {
      print(e);
    }
  }
}
