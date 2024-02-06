import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/cart/cart_view.dart';
import 'package:merchendise_galaxy/pages/product/product_model.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    Key? key,
    required this.productModel,
    required this.index,
  }) : super(key: key);
  final ProductModel productModel;
  final int index;

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final cartVM = CartViewModel();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 100,
      width: size.width,
      child: Row(
        children: [
          Checkbox(
              value: cartVM.selectedItems.containsKey(widget.index),
              checkColor: AppColor.whiteColor,
              activeColor: AppColor.lightRed,
              onChanged: (value) {
                if (cartVM.selectedItems.containsKey(widget.index)) {
                  setState(() {
                    cartVM.selectedItems.remove(widget.index);
                  });
                } else {
                  setState(() {
                    cartVM.selectedItems.addAll({widget.index: 1});
                  });
                }
              }),
          const SizedBox(width: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.productModel.productImage,
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.productModel.productName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        cartVM.selectedItems[widget.index] != null
                            ? '\$${200 * cartVM.selectedItems[widget.index]!}'
                            : "\$200",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColor.lightRed)),
                    Container(
                      width: 90,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColor.grayColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                cartVM.selectedItems.update(widget.index,
                                    (value) => value > 1 ? value - 1 : value);
                              });
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 20,
                            ),
                          ),
                          Text(
                            cartVM.selectedItems[widget.index] != null
                                ? cartVM.selectedItems[widget.index].toString()
                                : '0',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                cartVM.selectedItems
                                    .update(widget.index, (value) => value + 1);
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
