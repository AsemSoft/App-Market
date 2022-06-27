
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/screens/admin/addProduct_screen.dart';
import 'package:global_market/screens/admin/manageProduct.dart';
import 'package:global_market/screens/login_screen.dart';
import 'package:global_market/screens/signup_screen.dart';
// import 'package:global_market/screens/users/allPages.dart';
// import 'package:global_market/translations/locale_keys.g.dart';
// import 'package:easy_localization/easy_localization.dart';
List<Product> getProductByBrand(String pBrand,List<Product> allProducts) {
  List<Product> _products = [];
  try{
  for (var product in allProducts) {

    if (product.brand == pBrand) {
      _products.add(product);
    }
  }}on Error catch(ex)
  {
    print(ex);
  }
  return _products;
  print(_products);
}

List<Product> getProductByBrandCategory(String pCategory,String pBrand,List<Product> allProducts) {
  List<Product> _products = [];
  List<Product> _products1 = [];

  try{
    for (var product in allProducts)
    {
      if(product.pCategory == pCategory){
        _products.add(product);

      }
    }
    for (var product in _products)
    {
      if (product.brand == pBrand) {
        _products1.add(product);
      }
      print(_products1.toString());

    }

  }on Error catch(ex)
  {
    print(ex);
  }
  print(_products1);
  return _products1;
}




