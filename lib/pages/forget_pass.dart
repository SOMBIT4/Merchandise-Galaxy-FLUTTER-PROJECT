import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpasswordpage extends StatefulWidget {
  const Forgetpasswordpage({super.key});

  @override
  State<Forgetpasswordpage> createState() => _ForgetpasswordpageState();
}

class _ForgetpasswordpageState extends State<Forgetpasswordpage> {
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
        ],
      ),
    );
  }

//problem cant catch the error and cant make if true
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
              'Link has been sent if email exist',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    } catch (e) {
      print(e);

      /* Fluttertoast.showToast(
          msg: error.message.toString(), gravity: ToastGravity.TOP);*/
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            content: Text(
              //'Invalid email',
              e.toString(),
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }

/*
    String email = _emailcontroller.text;
    if (_emailcontroller.text.isNotEmpty) {
      if (await _auth.signinwithemailandpassword(email, 'password') != null) {
        emailnotfoundmessage();
      } else {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailcontroller.text.trim());
        // emailfoundmessage();
      }
    } else {
      emailnotfoundmessage();
    }
  }

  void emailnotfoundmessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'This Email is not registered',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void emailfoundmessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'This Email is  found',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }*/
  }
}
