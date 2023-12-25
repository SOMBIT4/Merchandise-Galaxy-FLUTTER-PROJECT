import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/components/my_button.dart';
import 'package:merchendise_galaxy/user_auth/firebase_auth_services.dart';

class Forgetpasswordpage extends StatefulWidget {
  const Forgetpasswordpage({super.key});

  @override
  State<Forgetpasswordpage> createState() => _ForgetpasswordpageState();
}

class _ForgetpasswordpageState extends State<Forgetpasswordpage> {
  // final Firebaseauthservice _auth = Firebaseauthservice();
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter Your Email and We Will Sent You a Password Reset link',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Colors.grey.shade300,
                filled: true,
                hintText: 'Gmail address',
              ),
            ),
          ),
          SizedBox(height: 10),
          MaterialButton(
            onPressed: passwordreset,
            child: Text(
              'Reset Password',
              style: TextStyle(fontSize: 20),
            ),
            color: Color.fromARGB(255, 170, 126, 246),
          ),
          /*Mybutton(onTap: () {
            FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailcontroller.text.toString())
                .then((value) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.deepPurple,
                    content: Text(
                      'The Email is found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              );
            }).onError((error, stackTrace) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.deepPurple,
                    content: Text(
                      'The Email is not found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              );
            });
          })*/
        ],
      ),
    );
  }

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            content: Text(
              'The Email is be found',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            content: Text(
              e.message.toString(),
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
    //String email = _emailcontroller.text;
    /* User? user = await _auth.resetpassword(email);
    if (user != null) {
      print('error happend');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.deepPurple,
            content: Text('The Email can\'t be found'
            ,style: TextStyle(color: Colors.white),),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.deepPurple,
            content: Text('The Email is found',
            style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }*/
  }
}
