import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    await FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              docids.add(element.reference.id);
            }));
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
          padding: const EdgeInsets.all(60),
          child: Container(
            height: 500,
            width: 400,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -- IMAGE with ICON
                Stack(
                  children: [
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

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          //return Text("Full Name: ${data['name']}");
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name : ${data['Name']}",
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Email Account : ${data['Email']}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          );
                        }

                        return const Text("loading");
                      },
                    )
                    /*  Expanded(
                        child: FutureBuilder(
                      future: getdocid(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: snapshot.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  docids[index],
                                  style: TextStyle(fontSize: 60),
                                ),
                              );
                            });
                      },
                    ))*/
                  ],
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
}
