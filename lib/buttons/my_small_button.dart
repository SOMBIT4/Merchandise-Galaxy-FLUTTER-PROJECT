import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;

  final Widget child;

  const MyButton({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.buttonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: child,
      ),
    );
  }
}
