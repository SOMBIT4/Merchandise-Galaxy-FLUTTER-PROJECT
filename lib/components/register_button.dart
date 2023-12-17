import 'package:flutter/material.dart';

class register extends StatelessWidget {
  final Function()? onTap;
  const register({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: const Text(
          'Register now',
          style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
