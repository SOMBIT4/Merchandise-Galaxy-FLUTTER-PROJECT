import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';
import 'package:merchendise_galaxy/res/components/dummy_products.dart';

class BottomTextWidget extends StatelessWidget {
  const BottomTextWidget(
      {Key? key,
      required this.price,
      required this.leadingText,
      required this.isSubT})
      : super(key: key);
  final String leadingText;
  final String price;
  final bool isSubT;

  @override
  Widget build(BuildContext context) {
    var newPrice = DummyProductList.cartList.isEmpty ? '00.0' : price;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingText,
          style: isSubT
              ? Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColor.buttonColor)
              : Theme.of(context).textTheme.titleMedium,
        ),
        Text('\$$newPrice',
            style: isSubT
                ? Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.lightRed)
                : Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColor.lightRed, fontSize: 18))
      ],
    );
  }
}
