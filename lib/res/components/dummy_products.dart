import 'package:merchendise_galaxy/pages/product/product_model.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';

class DummyProductList {
  static List<ProductModel> exploreList = <ProductModel>[
    ProductModel(
      productName: "Pizza",
      productImage: AppAssets.foodPizza,
      price: '200',
    ),
    ProductModel(
      productName: "Burger",
      productImage: AppAssets.foodBurger,
      price: '200',
    ),
    ProductModel(
      productName: "Steak",
      productImage: AppAssets.foodsteak,
      price: '200',
    ),
    ProductModel(
      productName: "Briyani",
      productImage: AppAssets.foodbiriyani,
      price: '200',
    ),
    ProductModel(
      productName: "Kebab",
      productImage: AppAssets.foodkebab,
      price: '200',
    ),
  ];

  static List<ProductModel> poloProduct = <ProductModel>[
    ProductModel(
      productName: "Black Polo",
      productImage: AppAssets.poloBlack,
      price: '200',
    ),
    ProductModel(
      productName: "Blue Polo",
      productImage: AppAssets.poloBlue,
      price: '200',
    ),
    ProductModel(
      productName: "Navy Blue Polo",
      productImage: AppAssets.poloNavyBlue,
      price: '200',
    ),
    ProductModel(
      productName: "White Polo",
      productImage: AppAssets.poloWhite,
      price: '200',
    ),
  ];

  static List<ProductModel> tProduct = <ProductModel>[
    ProductModel(
      productName: "Black T-Shirt",
      productImage: AppAssets.tBlack,
      price: '200',
    ),
    ProductModel(
      productName: "White T-Shirt",
      productImage: AppAssets.tWhite,
      price: '200',
    ),
    ProductModel(
      productName: "Grey T-Shirt",
      productImage: AppAssets.tGrey,
      price: '200',
    ),
  ];
}
