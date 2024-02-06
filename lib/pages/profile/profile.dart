//import 'dart:js';

//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';
//import 'package:merchendise_galaxy/pages/login_pages.dart';
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
        backgroundColor: const Color.fromARGB(255, 162, 213, 255),
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text(
            '        Profile',
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
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
                          data['ProfileImage'] != null
                              ? Stack(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${data['ProfileImage']}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child:
                                            Image.asset(AppAssets.profileImg),
                                      ),
                                    ),
                                  ],
                                ),
                          Column(
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
                        ],
                      ),
                    );
                  }
                  return const Text("loading");
                },
              ),

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
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/profileInfo'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.whiteColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Profile Information',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/addItem'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.whiteColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Add Items',
                      style:
                          TextStyle(color: Color.fromARGB(255, 55, 142, 241))),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),

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
