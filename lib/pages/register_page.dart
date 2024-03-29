import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/components/image_path.dart';
import 'package:merchendise_galaxy/components/my_button2.dart';
import 'package:merchendise_galaxy/components/my_texfield.dart';
import 'package:merchendise_galaxy/components/my_textfield1.dart';
import 'package:merchendise_galaxy/components/my_textfield3.dart';
import 'package:merchendise_galaxy/components/my_textfield4.dart';
import 'package:merchendise_galaxy/user_auth/firebase_auth_services.dart';

class registerPage extends StatefulWidget {
  registerPage({
    super.key,
  });

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final Firebaseauthservice _auth = Firebaseauthservice();
//text editing controller
  final namecontroller = TextEditingController();
  final usernamecontroller = TextEditingController();

  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                //logo
                Image.asset(
                  'lib/images/logo1.png',
                  height: 105,
                  // width: 100,
                ),

                const SizedBox(height: 10),

                const Text(
                  'Let\'s create an account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.5,
                  ),
                ),

                const SizedBox(height: 20),
                //name field
                Mytextfield3(
                  controller: namecontroller,
                  hintText: 'Name',
                  obscureText: false,
                ),

                const SizedBox(height: 20),
                //username field
                Mytextfield(
                  controller: usernamecontroller,
                  hintText: 'Gmail address',
                  obscureText: false,
                ),

                const SizedBox(height: 20),
                //password text field
                Mytextfield1(
                  controller: passwordcontroller,
                  hintText: 'Password',
                ),

                const SizedBox(height: 20),
                //confirm password text field
                Mytextfield4(
                  controller: confirmpasswordcontroller,
                  hintText: 'Confirm Password',
                ),

                const SizedBox(height: 20),
                //sign up button
                Mybutton1(
                  onTap: signup,
                ),

                const SizedBox(height: 20),

                //or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google
                    /* Imagepath(onTap: () {}, image: 'lib/images/google.png'),

                    SizedBox(width: 25),
                    //fb
                    Imagepath(onTap: () {}, image: 'lib/images/facebook.png'),

                    SizedBox(width: 25),
                    //twitter
                    Imagepath(onTap: () {}, image: 'lib/images/twitter1.png'),
                  */
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/login_page', (route) => false),
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signup() async {
    String email = usernamecontroller.text;
    String password = passwordcontroller.text;
//show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //sign up
    if (namecontroller.text.isNotEmpty &&
        usernamecontroller.text.isNotEmpty &&
        passwordcontroller.text.isNotEmpty &&
        confirmpasswordcontroller.text.isNotEmpty) {
      if (passwordcontroller.text == confirmpasswordcontroller.text) {
        User? user = await _auth.signupwithemailandpassword(email, password);

        if (user != null) {
          //add user details
          adduserdetails(namecontroller.text, usernamecontroller.text,
              passwordcontroller.text);
          print("Password  match");
          Navigator.pushNamed(context, '/product_page');
        } else {
          Navigator.pop(context);
          alreayregistermessage();
        }
      } else {
        print("Password don't  match");
        Navigator.pop(context);
        passworddontmatchmessage();
      }
    } else {
      print("Some error occured");
      Navigator.pop(context);
      fillfieldmessage();
    }
  }

  Future adduserdetails(String name, String email, String password) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Name': name,
      'Email': email,
      'Password': password,
    });
  }

  void passworddontmatchmessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Password Don\'t  Match',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void fillfieldmessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'You Must Fill Up All The Fields',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void alreayregistermessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Ethier this Email is already registered or the password is too short. Please!Enter a 6 digit password or Network issue',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
