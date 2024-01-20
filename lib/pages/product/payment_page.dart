//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:merchendise_galaxy/buttons/container_button.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => PaymentState();
}

class PaymentState extends State<PaymentPage> {
  int _type = 1;
  void _handleRadio(Object? e) => setState(() {
        _type = e as int;
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Payment Method"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: ListView(children: [
              Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: size.width,
                    height: 55,
                    margin: const EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      border: _type == 1
                          ? Border.all(width: 1, color: Colors.red)
                          : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _type,
                                  onChanged: _handleRadio,
                                  activeColor: Colors.red,
                                ),
                                Text(
                                  "Bkash",
                                  style: _type == 1
                                      ? TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)
                                      : TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                ),
                              ],
                            ),
                            // Image.asset(
                            //   "images/bkash.png",
                            //   width: 50,
                            //   fit: BoxFit.cover,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: size.width,
                    height: 55,
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      border: _type == 2
                          ? Border.all(width: 1, color: Colors.red)
                          : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: _type,
                                  onChanged: _handleRadio,
                                  activeColor: Colors.red,
                                ),
                                Text(
                                  "Nagad",
                                  style: _type == 2
                                      ? TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)
                                      : TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                ),
                              ],
                            ),
                            // Image.asset(
                            //   "images/nagad.png",
                            //   width: 50,
                            //   fit: BoxFit.cover,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: size.width,
                    height: 55,
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      border: _type == 3
                          ? Border.all(width: 1, color: Colors.red)
                          : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 3,
                                  groupValue: _type,
                                  onChanged: _handleRadio,
                                  activeColor: Colors.red,
                                ),
                                Text(
                                  "Credit Card",
                                  style: _type == 3
                                      ? TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)
                                      : TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                ),
                              ],
                            ),
                            Spacer(),
                            // Image.asset(
                            //   "images/visa.png",
                            //   width: 25,
                            //   fit: BoxFit.cover,
                            // ),
                            SizedBox(width: 8),
                            // Image.asset(
                            //   "images/mastercard.png",
                            //   width: 25,
                            //   fit: BoxFit.cover,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: size.width,
                    height: 55,
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      border: _type == 4
                          ? Border.all(width: 1, color: Colors.red)
                          : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 4,
                                  groupValue: _type,
                                  onChanged: _handleRadio,
                                  activeColor: Colors.red,
                                ),
                                Text(
                                  "Paypal",
                                  style: _type == 4
                                      ? TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)
                                      : TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                ),
                              ],
                            ),
                            // Image.asset(
                            //   "images/paypal.png",
                            //   width: 65,
                            //   fit: BoxFit.cover,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sub-Total",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "\৳200.40",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping Fee",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "\৳50",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "\৳250.4",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  InkWell(
                    onTap: () {},
                    child: ContainerButton(
                      itext: "Confirm Payment",
                      containerWidth: size.width,
                      bgColor: Colors.lightGreen,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
