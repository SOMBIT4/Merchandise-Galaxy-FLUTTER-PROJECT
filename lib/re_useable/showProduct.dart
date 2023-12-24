import 'package:flutter/material.dart';

import 'package:merchendise_galaxy/buttons/my_small_button.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                AppAssets.foodBurger,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Name',
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
                '\$280',
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
                     ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text(
                          'Product added',
                          ),
                          backgroundColor: Colors.purple,
                         ),
                        );
                    
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
    );
  }
}
