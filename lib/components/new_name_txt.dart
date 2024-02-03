import 'package:flutter/material.dart';

class NewName extends StatelessWidget {
  final controller;
  // final String hintText;
  final bool obscureText;

  const NewName({
    super.key,
    required this.controller,
    //required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          label: Text('Enter New Name'),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            //borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          filled: true,
          // hintText: hintText,
        ),
      ),
    );
  }
}
