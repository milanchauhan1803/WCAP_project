import '../model/product.dart';

class ProductDetailsArguments {
  List<Product> listRelatedProducts = [];
  int productId;

  ProductDetailsArguments(this.listRelatedProducts, this.productId);
}
