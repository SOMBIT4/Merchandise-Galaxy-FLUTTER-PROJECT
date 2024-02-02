import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/cart/my_cart.dart';
import 'package:merchendise_galaxy/re_useable/shopingcard.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.arrow_back,
              size: 28,
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18),
        ),
        ShoppingCardWidget(onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const CartView()));
        }),
      ],
    );
  }
}
