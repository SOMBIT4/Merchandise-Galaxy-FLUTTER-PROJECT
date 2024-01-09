import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:merchendise_galaxy/pages/profile/utils.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateProfileScreen> {
//   void _navigateToGallery() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//               const UploadImageAndMore()), // Replace BlankPage with the actual blank page you want to navigate to
//     );
//   }
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  // Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               top: 20,
  //               right: 20,
  //               left: 20,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Center(
  //                 child: Text("Upload image : "),
  //               ),

  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Center(
  //                   child: IconButton(
  //                       onPressed: () async {
  //                         // add the package image_picker
  //                         final file = await ImagePicker()
  //                             .pickImage(source: ImageSource.gallery);
  //                         if (file == null) return;

  //                         String fileName =
  //                             DateTime.now().microsecondsSinceEpoch.toString();

  //                         // Get the reference to storage root
  //                         // We create the image folder first and insider folder we upload the image
  //                         Reference referenceRoot =
  //                             FirebaseStorage.instance.ref();
  //                         Reference referenceDireImages =
  //                             referenceRoot.child('images');

  //                         // we have creata reference for the image to be stored
  //                         Reference referenceImageaToUpload =
  //                             referenceDireImages.child(fileName);

  //                         // For errors handled and/or success
  //                         try {
  //                           await referenceImageaToUpload
  //                               .putFile(File(file.path));

  //                           // We have successfully upload the image now
  //                           // make this upload image link in firebase database

  //                           imageUrl =
  //                               await referenceImageaToUpload.getDownloadURL();
  //                         } catch (error) {
  //                           //some error
  //                         }
  //                       },
  //                       icon: const Icon(Icons.camera_alt))),
  //               //   Center(
  //               //       child: ElevatedButton(
  //               //           onPressed: () async {
  //               //             if (imageUrl.isEmpty) {
  //               //               ScaffoldMessenger.of(context).showSnackBar(
  //               //                   const SnackBar(
  //               //                       content: Text(
  //               //                           "Please select and upload image")));
  //               //               return;
  //               //             }
  //               //             final String name = _nameController.text;
  //               //             final int? number =
  //               //                 int.tryParse(_numberController.text);
  //               //             if (number != null) {
  //               //               await _items.add({
  //               //                 // Add items in you firebase firestore
  //               //                 "name": name,
  //               //                 "number": number,
  //               //                 "image": imageUrl,
  //               //               });
  //               //               _nameController.text = '';
  //               //               _numberController.text = '';
  //               //               Navigator.of(context).pop();
  //               //             }
  //               //           },
  //               //           child: const Text('Create')))
  //             ],
  //           ),
  //         );
  //       });
  // }

  // late Stream<QuerySnapshot> _stream;
  // @override
  // void initState() {
  //   super.initState();
  //   _stream = FirebaseFirestore.instance.collection('Upload_Items').snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Padding(
          padding: EdgeInsets.only(left: 45),
          child: Text('Edit Profile',
              style: TextStyle(fontSize: 25, color: Colors.black)),
        ),
      ),
      body: SingleChildScrollView(
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
                          onPressed: selectImage, icon: Icon(Icons.camera_alt)),
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
                          prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text('Edit Password'),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                            icon: const Icon(LineAwesomeIcons.eye_slash),
                            onPressed: () {}),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // -- Form Submit Button
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 35, 255, 46)
                                .withOpacity(0.3),
                            elevation: 0,
                            foregroundColor: Color.fromARGB(255, 58, 255, 68),
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: Text('Done',
                            style: TextStyle(
                                color: Color.fromARGB(255, 14, 95, 18))),
                      ),
                    ),
                    const SizedBox(height: 20),

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
      ),
    );
  }
}
