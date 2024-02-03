import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:merchendise_galaxy/components/image_path.dart';
import 'package:merchendise_galaxy/components/my_button.dart';
import 'package:merchendise_galaxy/components/my_texfield.dart';
import 'package:merchendise_galaxy/components/my_textfield1.dart';
import 'package:merchendise_galaxy/components/register_button.dart';
import 'package:merchendise_galaxy/pages/login_reg/forget_pass.dart';
import 'package:merchendise_galaxy/user_auth/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Firebaseauthservice _auth = Firebaseauthservice();
//text editing controller

  final usernamecontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();

    super.dispose();
  }

  @override
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
                Image.asset('lib/images/logo1.png', height: 180),

                const SizedBox(height: 30),

                const Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 25),
                //username field
                Mytextfield(
                  controller: usernamecontroller,
                  // hintText: 'Gmail address',
                  obscureText: false,
                ),

                const SizedBox(height: 20),
                //password text field
                Mytextfield1(
                  controller: passwordcontroller,
                  hintText: 'Password',
                ),

                //forgot password
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Forgetpasswordpage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                //sign in button
                Mybutton(
                  onTap: signin,
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
                const SizedBox(height: 30),
                //google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google
                    Imagepath(
                        onTap: () => _signinGoogle(),
                        image: 'lib/images/google.png'),

                    /* SizedBox(width: 25),
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
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    register(
                        onTap: () =>
                            Navigator.pushNamed(context, '/register_page')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signin() async {
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
//sign in
    User? user = await _auth.signinwithemailandpassword(email, password);
    if (user != null) {
      print("user succesfully logined");
      Navigator.pushReplacementNamed(context, '/product_page');
    } else {
      print("Some error occured");
      Navigator.pop(context);
      wrongemailorpasswordmessage();
    }
  }

  void wrongemailorpasswordmessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Incorrect Email/Password or Network Issue',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  _signinGoogle() async {
    final GoogleSignIn _googlesignin = GoogleSignIn();
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googlesignin.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            //add user data instore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'Name': user.displayName,
              'Email': user.email,
              //'Password':
            });
          }
        }
        Navigator.pushNamed(context, '/product_page');
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
    }
  }
}
