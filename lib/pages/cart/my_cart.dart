import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/buttons/my_button.dart';
import 'package:merchendise_galaxy/pages/cart/cart_items.dart';
import 'package:merchendise_galaxy/pages/cart/cart_view.dart';
import 'package:merchendise_galaxy/pages/product/payment_page.dart';
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
        backgroundColor: const Color.fromARGB(255, 162, 213, 255),
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text(
            '        Cart',
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          SizedBox(
            height: size.height * 0.58,
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
          const SizedBox(height: 35),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60).copyWith(top: 30),
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
                  MyButton2(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentPage()));
                      },
                      child: Text(
                        "Pay Now",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                            ),
                      )),
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
