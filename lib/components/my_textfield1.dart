import 'package:flutter/material.dart';

class Mytextfield1 extends StatefulWidget {
  final controller;
  final String hintText;

  const Mytextfield1({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<Mytextfield1> createState() => _Mytextfield1State();
}

class _Mytextfield1State extends State<Mytextfield1> {
  bool _obsecuretext = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _obsecuretext,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          label: Text('Password'),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            //borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obsecuretext = !_obsecuretext;
                });
              },
              icon: Icon(
                _obsecuretext ? Icons.visibility_off : Icons.visibility,
              )),
          fillColor: Colors.grey.shade300,
          filled: true,
          //  hintText: widget.hintText,
        ),
      ),
    );
  }
}
