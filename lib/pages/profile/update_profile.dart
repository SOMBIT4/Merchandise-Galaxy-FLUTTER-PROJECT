import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // text fiedl controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection("Upload_Items");
  // collection name must be same as firebase collection name

  String imageUrl = '';

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text("Choose"),
                ),
                // TextField(
                //   controller: _nameController,
                //   decoration: const InputDecoration(
                //       labelText: 'Name', hintText: 'eg Elon'),
                // ),
                // TextField(
                //   controller: _numberController,
                //   decoration: const InputDecoration(
                //       labelText: 'Number', hintText: 'eg 10'),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: IconButton(
                    onPressed: () async {
                      // add the package image_picker
                      final file = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (file == null) return;

                      String fileName =
                          DateTime.now().microsecondsSinceEpoch.toString();

                      // Get the reference to storage root
                      // We create the image folder first and insider folder we upload the image
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDireImages =
                          referenceRoot.child('images');

                      // we have creata reference for the image to be stored
                      Reference referenceImageaToUpload =
                          referenceDireImages.child(fileName);

                      // For errors handled and/or success
                      try {
                        await referenceImageaToUpload.putFile(File(file.path));

                        // We have successfully upload the image now
                        // make this upload image link in firebase database

                        imageUrl =
                            await referenceImageaToUpload.getDownloadURL();
                      } catch (error) {
                        //some error
                      }
                    },
                    icon: const Icon(Icons.camera_alt),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (imageUrl.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select and upload image"),
                          ),
                        );
                        return;
                      }
                      final int? number = int.tryParse(_numberController.text);
                      if (number != null) {
                        await _items.add({
                          // Add items in you firebase firestore

                          "image": imageUrl,
                        });
                        // _nameController.text = '';
                        // _numberController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Create'),
                  ),
                )
              ],
            ),
          );
        });
  }

  late Stream<QuerySnapshot> _stream;
  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> document = querySnapshot.docs;

              // We need to Convert your documnets to Maps to display
              List<Map> items = document.map((e) => e.data() as Map).toList();

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
                      const SizedBox(height: 50),

                      // -- Form Fields
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Edit Name'),
                                  prefixIcon: Icon(LineAwesomeIcons.user)),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Edit Email'),
                                  prefixIcon:
                                      Icon(LineAwesomeIcons.envelope_1)),
                            ),

                            const SizedBox(height: 60),

                            // -- Form Submit Button
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 35, 255, 46)
                                            .withOpacity(0.3),
                                    elevation: 0,
                                    foregroundColor:
                                        Color.fromARGB(255, 58, 255, 68),
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: Text('Done',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 14, 95, 18))),
                              ),
                            ),
                            const SizedBox(height: 30),

                            // -- Created Date and Delete Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
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
                      ),
                    ],
                  ),
                ),
              );
              // ListView.builder(
              //     itemCount: items.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       Map thisItems = items[index];
              //       return ListTile(
              //           title: Text(
              //             "${thisItems['name']}",
              //             style: const TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 17),
              //           ),
              //           subtitle: Text("${thisItems['number']}"),
              //           leading: CircleAvatar(
              //             radius: 27,
              //             child: thisItems.containsKey('image')
              //                 ? ClipOval(
              //                     child: Image.network(
              //                       "${thisItems['image']}",
              //                       fit: BoxFit.cover,
              //                       height: 70,
              //                       width: 70,
              //                     ),
              //                   )
              //                 : const CircleAvatar(),
              //           ));
              //     });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _create();
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
