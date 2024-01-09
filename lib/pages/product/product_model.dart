class ProductModel {
  String productName;
  String? productDescription;
  String productImage;
  String price;

  ProductModel({
    required this.productName,
    required this.productImage,
    this.productDescription,
    required this.price,
  });
}
