import 'package:flutter/material.dart';

class Imagepath extends StatelessWidget {
  final String image;
  final Function()? onTap;
  const Imagepath({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(255, 189, 184, 184)),
        child: Image.asset(
          image,
          height: 35,
        ),
      ),
    );
  }
}
