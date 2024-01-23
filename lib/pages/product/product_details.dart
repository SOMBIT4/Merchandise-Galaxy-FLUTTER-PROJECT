import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/product/product_model.dart';
import 'package:merchendise_galaxy/pages/product/utils.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.productModel})
      : super(key: key);

  final ProductModel productModel;

  @override
  State<ProductDetails> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetails> {
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: size.height * 0.5,
                width: size.width,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 22)
                    .copyWith(top: size.height * 0.06),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.productModel.productImage),
                    fit: BoxFit.fill,
                  ),
                ),
                // child: const AppBarWidget(title: 'Product'),
              ),
              Positioned(
                bottom: -25,
                right: 20,
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        spreadRadius: 3.0,
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: 28,
                    color: AppColor.redColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              '\$${widget.productModel.price}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColor.redColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  widget.productModel.productName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Spacer(),
                for (int i = 1; i <= 5; i++)
                  Icon(
                    i != 5 ? Icons.star_sharp : Icons.star_border,
                    color: AppColor.shadowColor,
                  ),
                const SizedBox(width: 4),
                Text(
                  '4.5',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
                // children: getColors(),
                ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Description',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                // var isAdded = Utils.addToCart(widget.productModel);
                // if (isAdded) {
                //   Utils.toastMessage();
                // } else {
                //   Utils.toastMessage(message: 'Cant add to Cart');
                // }
              },
              child: Container(
                height: 65,
                width: size.width * 0.55,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.buttonColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 29,
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Add to Cart',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColor.whiteColor),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // List<Widget> getColors() {
  //   return List.generate(
  //     colorList.length,
  //     (index) => Padding(
  //       padding: const EdgeInsets.only(right: 8.0, top: 10),
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           InkWell(
  //             onTap: () {
  //               setState(() {
  //                 selectedColor = index;
  //               });
  //             },
  //             child: Icon(
  //               Icons.circle,
  //               color: colorList[index],
  //               size: selectedColor == index ? 20 : 30,
  //             ),
  //           ),
  //           Visibility(
  //             visible: selectedColor == index,
  //             child: Icon(
  //               Icons.circle_outlined,
  //               color: colorList[index],
  //               size: 36,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   ).toList();
  // }

  // List<Color> colorList = <Color>[
  //   AppColor.shadowColor,
  //   AppColor.shadowColor,
  //   AppColor.buttonColor
  // ];
}
