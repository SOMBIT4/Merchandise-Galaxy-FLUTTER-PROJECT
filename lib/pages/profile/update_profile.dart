import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  late User _user;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String imageUrl = '';

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    // add the package image_picker
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    // Get the reference to storage root
    // We create the image folder first and insider folder we upload the image
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDireImages = referenceRoot.child('images');

    // we have creata reference for the image to be stored
    Reference referenceImageaToUpload = referenceDireImages.child(fileName);

    // For errors handled and/or success
    try {
      await referenceImageaToUpload.putFile(File(file.path));

      // We have successfully upload the image now
      // make this upload image link in firebase database

      imageUrl = await referenceImageaToUpload.getDownloadURL();
      print("url is ---------------------------------------");
      print(imageUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateUserProfile2() async {
    try {
      users.doc(_user.uid).update(
        {
          'Name': _usernameController.text,
          'Email': _emailController.text,
          'ProfileImage': imageUrl,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User profile updated successfully!'),
        ),
      );
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser!;
    DocumentSnapshot userSnapshot = await users.doc(_user.uid).get();

    setState(() {
      _usernameController.text = userSnapshot['Name'];
      _emailController.text = userSnapshot['Email'];
      imageUrl = userSnapshot['ProfileImage'];
    });
  }

  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _getUserData();

    _stream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Container(
          padding: EdgeInsets.only(left: 60),
          child: const Text("Edit Profile"),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Some error occured${snapshot.error}"),
              );
            }
            // Now , Cheeck if datea arrived?
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      // -- IMAGE with ICON
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(AppAssets.profileImg)),
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
                              child: IconButton(
                                  onPressed: _create,
                                  icon: Icon(Icons.camera_alt)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LinearProgressIndicator();
                          }

                          if (snapshot.hasError) {
                            return const Text("Something went wrong");
                          }

                          if (snapshot.data == null) {
                            return const Text("No data");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return Container(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 5),
                                                color: Color.fromARGB(
                                                        255, 82, 85, 83)
                                                    .withOpacity(.2),
                                                spreadRadius: 2,
                                                blurRadius: 10)
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    size: 36,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 200,
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 17),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "User_Name ",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${data['Name']}",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: AppColor.whiteColor),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              LineAwesomeIcons.alternate_pencil,
                                              color: Colors.black,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 5),
                                                color: Color.fromARGB(
                                                        255, 82, 85, 83)
                                                    .withOpacity(.2),
                                                spreadRadius: 2,
                                                blurRadius: 10)
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 70,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.mail,
                                                    size: 36,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 220,
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 17),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "User_E-mail ",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${data['Email']}",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: AppColor.whiteColor),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              LineAwesomeIcons.alternate_pencil,
                                              color: Colors.black,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: ElevatedButton(
                                          onPressed: _updateUserProfile2,
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                      255, 35, 255, 46)
                                                  .withOpacity(0.3),
                                              elevation: 0,
                                              foregroundColor: Color.fromARGB(
                                                  255, 58, 255, 68),
                                              side: BorderSide.none,
                                              shape: const StadiumBorder()),
                                          child: Text('Done',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),

                                  // -- Created Date and Delete Button
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent
                                                .withOpacity(0.1),
                                            elevation: 0,
                                            foregroundColor: Colors.red,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none),
                                        child: const Text('Delete Account'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }

                          return const Text("loading");
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
