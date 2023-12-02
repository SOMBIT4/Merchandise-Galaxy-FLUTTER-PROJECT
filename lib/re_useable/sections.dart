import 'package:flutter/material.dart';

import 'package:merchendise_galaxy/re_useable/showProduct.dart';

class SectionListTile extends StatelessWidget {
  const SectionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 35,
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
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              width: 16,
            ),
            itemBuilder: (context, index) {
              return const ProductListTile();
            },
          ),
        ),
      ],
    );
  }
}
