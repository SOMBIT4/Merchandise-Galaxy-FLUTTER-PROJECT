import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/chat/Chat.dart';
import 'package:merchendise_galaxy/pages/product/bottom_navbar.dart';
import 'package:merchendise_galaxy/pages/product/my_cart.dart';
import 'package:merchendise_galaxy/pages/product/product_details.dart';
import 'package:merchendise_galaxy/pages/profile/profile.dart';
import 'package:merchendise_galaxy/re_useable/showProduct.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';
import 'package:merchendise_galaxy/res/components/dummy_products.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _HomePageState();
}

class _HomePageState extends State<ProductPage> {
  void _navigateToMyCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyCart()),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const ProfileScreen()), // Replace BlankPage with the actual blank page you want to navigate to
    );
  }

  void _navigateToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomeScreen()), // Replace BlankPage with the actual blank page you want to navigate to
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      bottomNavigationBar: const BottomNavigation(),
      body: ListView(
        children: [
          SafeArea(
            minimum:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Merchandise',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Fontmain',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Galaxy',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Fontmain',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 55,
                    ),
                    GestureDetector(
                      onTap: _navigateToMyCart,
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 42,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: _navigateToProfile,
                      child: Container(
                        height: 40,
                        width: 44,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColor.buttonColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Icon(
                          Icons.person_2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    // Expanded(child: ),
                    Expanded(
                      child: Container(
                        height: 34,
                        //width: 50,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.shadowColor,
                              spreadRadius: 2.2,
                              blurRadius: 5,
                              offset: Offset(-3, 1),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            prefixIcon: Image.asset(
                              AppAssets.searchIcon,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),

                    GestureDetector(
                      onTap: _navigateToHomeScreen,
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColor.buttonColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Product',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 262,
                  child: ListView.separated(
                    itemCount: DummyProductList.exploreList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                    itemBuilder: (context, index) {
                      var foodProduct = DummyProductList.exploreList[index];
                      return ProductListTile(
                        productName: foodProduct.productName,
                        price: foodProduct.price,
                        image: foodProduct.productImage,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                productModel: foodProduct,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Product',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 262,
                  child: ListView.separated(
                    itemCount: DummyProductList.poloProduct.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                    itemBuilder: (context, index) {
                      var poloProduct = DummyProductList.poloProduct[index];
                      return ProductListTile(
                        image: poloProduct.productImage,
                        price: poloProduct.price,
                        productName: poloProduct.productName,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                productModel: poloProduct,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Product',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 262,
                  child: ListView.separated(
                    itemCount: DummyProductList.tProduct.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                    itemBuilder: (context, index) {
                      var tProduct = DummyProductList.tProduct[index];
                      return ProductListTile(
                        price: tProduct.price,
                        productName: tProduct.productName,
                        image: tProduct.productImage,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                productModel: tProduct,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
