import 'package:flutter/cupertino.dart';
import 'package:global_market/models/product.dart';


class CartItem extends ChangeNotifier
{
  List<Product> products=[];
  addProduct(Product product)
  {
    products.add(product);
    notifyListeners();
  }

  deleteProductInCart(Product product){
    products.remove(product);
    notifyListeners();
  }
}