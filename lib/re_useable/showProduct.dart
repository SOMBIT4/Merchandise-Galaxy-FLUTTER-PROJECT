import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/buttons/my_small_button.dart';
import 'package:merchendise_galaxy/pages/cart/utils.dart';
import 'package:merchendise_galaxy/pages/product/product_model.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.productModel,
    required this.onTap,
  });

  final ProductModel productModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        width: 150,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 2 / 1.75,
                child: Image.asset(
                  productModel.productImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              productModel.productName,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 0,
            ),
            Text(
              'description',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  'Price : ',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  '\$${productModel.price}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                    onTap: () {
                      var isAdded = Utils.addToCart(productModel);
                      if (isAdded) {
                        Utils.toastMessage();
                      } else {
                        Utils.toastMessage(message: 'Cant add to Cart');
                      }
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //       'Product added',
                      //     ),
                      //     backgroundColor: Colors.purple,
                      //   ),
                      // );
                    },
                    child: Text(
                      "Add To Cart",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
