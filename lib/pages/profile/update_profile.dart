import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchendise_galaxy/components/new_name_txt.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateProfileScreen> {
  final newusername = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  late User _user;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String? _profileImageUrl;
  String imageUrl = '';

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    if (file == null) return;

    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    // reference to storage root

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDireImages = referenceRoot.child('images');

    // reference for the image to be stored
    Reference referenceImageaToUpload = referenceDireImages.child(fileName);

    try {
      await referenceImageaToUpload.putFile(File(file.path));

      imageUrl = await referenceImageaToUpload.getDownloadURL();

      setState(() {
        _profileImageUrl = imageUrl;
      });
      Navigator.pop(context);

      print("url is ---------------------------------------");
      print(imageUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProfile() async {
    try {
      logout() async {
        try {
          await GoogleSignIn().signOut();
          await FirebaseAuth.instance.signOut();

          //  await FirebaseAuth.instance.delete();
        } catch (e) {
          print(e);
        }
      }

      Navigator.pushNamedAndRemoveUntil(
          context, '/login_page', (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User profile deleted successfully!'),
        ),
      );
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.delete();
      }
      users.doc(_user.uid).delete();
    } catch (e) {
      print('Error deleting user profile: $e');
    }
  }

  Future<void> _updateUserProfile() async {
    if (newusername.text.isEmpty || imageUrl.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Text(
              'Please select an image and a new name',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    } else {
      try {
        users.doc(_user.uid).update(
          {
            'Name': newusername.text,
            'Email': _emailController.text,
            'ProfileImage': imageUrl,
          },
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User profile updated successfully!'),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, '/profileScreen', (route) => false);
      } catch (e) {
        print('Error updating user profile: $e');
      }
    }
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser!;
    DocumentSnapshot userSnapshot = await users.doc(_user.uid).get();

    setState(
      () {
        _usernameController.text = userSnapshot['Name'];
        _emailController.text = userSnapshot['Email'];
        imageUrl = userSnapshot['ProfileImage'];
      },
    );
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
              // QuerySnapshot querySnapshot = snapshot.data;
              // List<QueryDocumentSnapshot> document = querySnapshot.docs;

              // // We need to Convert your documnets to Maps to display
              // List<Map> items = document.map((e) => e.data() as Map).toList();

              // Map thisItems = items[index];

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(height: 0),
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
                              width: 700,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      // -- IMAGE with ICON
                                      Stack(
                                        children: [
                                          _profileImageUrl == null
                                              ? data['ProfileImage'] == null
                                                  ? Stack(
                                                      children: [
                                                        SizedBox(
                                                          width: 120,
                                                          height: 120,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child: Image.asset(
                                                                AppAssets
                                                                    .profileImg),
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
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child:
                                                                Image.network(
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
                                                            BorderRadius
                                                                .circular(100),
                                                        child: Image.network(
                                                          _profileImageUrl!,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: AppColor.whiteColor),
                                              child: IconButton(
                                                  onPressed: _create,
                                                  icon: Icon(Icons.camera_alt)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            height: 80,
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
                                                        MainAxisAlignment
                                                            .center,
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 25),
                                      //username field
                                      NewName(
                                        controller: newusername,
                                        //hintText: 'Enter new name ',
                                        obscureText: false,
                                      ),

                                      const SizedBox(height: 20),
                                      SizedBox(
                                        height: 25,
                                      ),

                                      SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: _updateUserProfile,
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                              255, 35, 255, 46)
                                                          .withOpacity(0.3),
                                                  elevation: 0,
                                                  foregroundColor:
                                                      Color.fromARGB(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              deleteProfile();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .redAccent
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
