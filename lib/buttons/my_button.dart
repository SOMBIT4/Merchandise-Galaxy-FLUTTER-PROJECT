import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {
  final void Function()? onTap;

  final Widget child;

  const MyButton2({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
        child: child,
      ),
    );
  }
}
