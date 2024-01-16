import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text('Profile Information',
              style: TextStyle(fontSize: 25, color: Colors.black)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            height: 500,
            width: 600,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -- IMAGE with ICON
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(AppAssets.profileImg),
                  ),
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
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 100,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      color: Color.fromARGB(255, 82, 85, 83)
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
                                    padding: EdgeInsets.only(left: 20, top: 17),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User_Name ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${data['Name']}",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 100,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 5),
                                      color: Color.fromARGB(255, 82, 85, 83)
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
                                    height: 100,
                                    width: 220,
                                    padding: EdgeInsets.only(left: 20, top: 17),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "User_E-mail ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${data['Email']}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )

                            // itemProfile('User_Name', '${data['Name']}',
                            //  CupertinoIcons.person)
                            // Text(
                            //   "User_Name : -   ${data['Name']}",
                            //   style: const TextStyle(fontSize: 20),
                            // ),
                            // const SizedBox(
                            //   height: 30,
                            // ),
                            // Text(
                            //   ' ${data['Email']}',
                            //   style: const TextStyle(fontSize: 28),
                            // ),
                          ],
                        ),
                      );
                    }

                    return const Text("loading");
                  },
                ),
                /* const SizedBox(height: 40),
                Text('Name', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 60),
                Text('Email', style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 40),*/

                // -- Form Fields
                /* Form(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Edit Email'),
                            prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  // itemProfile(String subtitle, String title, IconData iconData) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //             offset: Offset(0, 5),
  //             color: Color.fromARGB(255, 82, 85, 83).withOpacity(.2),
  //             spreadRadius: 2,
  //             blurRadius: 10)
  //       ],
  //     ),
  //     child: ListTile(
  //       subtitle: Text(subtitle),
  //       title: Text(title),
  //       leading: Icon(iconData),
  //       trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
  //       tileColor: Colors.white,
  //     ),
  //   );
  // }
}
