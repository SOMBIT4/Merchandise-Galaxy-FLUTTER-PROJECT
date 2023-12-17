import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/components/image_path.dart';
import 'package:merchendise_galaxy/components/my_button.dart';
import 'package:merchendise_galaxy/components/my_texfield.dart';
import 'package:merchendise_galaxy/components/my_textfield1.dart';

class registerPage extends StatefulWidget {
  // final Function()? onTap;
  registerPage({
    super.key,
    /*required this.onTap*/
  });

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
//text editing controller
  final usernamecontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

//sign user in method
  void signinuser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                //logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 20),

                const Text(
                  'Let\'s create an account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 25),
                //name field
                Mytextfield(
                  controller: usernamecontroller,
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
                Mytextfield1(
                  controller: passwordcontroller,
                  hintText: 'Confirm Password',
                ),

                const SizedBox(height: 20),
                //sign in button
                Mybutton(
                  onTap: () => Navigator.pushNamed(context, '/product_page'),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google
                    Imagepath(image: 'lib/images/google.png'),

                    SizedBox(width: 25),
                    //fb
                    Imagepath(image: 'lib/images/facebook.png'),

                    SizedBox(width: 25),
                    //apple
                    Imagepath(image: 'lib/images/apple.png'),
                  ],
                ),
                const SizedBox(height: 20),
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
                    // GestureDetector(
                    // onTap: widget.onTap,
                    /*child: */ const Text(
                      'Login now',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
