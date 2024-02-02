import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class ShoppingCardWidget extends StatelessWidget {
  const ShoppingCardWidget({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 29,
          ),
          Positioned(
            top: -4,
            right: -4,
            child: Icon(
              Icons.circle,
              color: AppColor.redColor,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}
