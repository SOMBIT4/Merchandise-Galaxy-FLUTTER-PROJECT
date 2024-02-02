import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/cart/bottom_text.dart';
import 'package:merchendise_galaxy/pages/cart/cart_items.dart';
import 'package:merchendise_galaxy/re_useable/appbar.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';
import 'package:merchendise_galaxy/res/components/dummy_products.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final cartVM = CartViewModel();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backGroundColor,
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: const AppBarWidget(title: 'Cart'),
        iconTheme: IconThemeData(color: AppColor.buttonColor),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          SizedBox(
            height: size.height * 0.43,
            child: ListView.separated(
              itemCount: DummyProductList.cartList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (context, child) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                return CartItemWidget(
                  productModel: DummyProductList.cartList[index],
                  index: index,
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 50),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.shadowColor,
                      spreadRadius: 6,
                      blurRadius: 5,
                      offset: const Offset(-5, -4.0)),
                ],
              ),
              child: Column(
                children: [
                  const BottomTextWidget(
                    price: '200.0',
                    leadingText: 'Selected Items',
                    isSubT: false,
                  ),
                  const SizedBox(height: 15),
                  const BottomTextWidget(
                      price: '30.0',
                      leadingText: 'Shipping Fee',
                      isSubT: false),
                  const SizedBox(height: 15),
                  Divider(
                    color: AppColor.grayColor,
                  ),
                  const SizedBox(height: 25),
                  const BottomTextWidget(
                      price: '230.0', leadingText: 'Subtotal', isSubT: true),
                  const SizedBox(height: 22),
                  //check out button
                  // CustomButton(
                  //     width: size.width * 0.7, title: 'Checkout', onTap: () {}),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
