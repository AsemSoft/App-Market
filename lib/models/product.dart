import 'dart:io';
import 'package:flutter/material.dart';
import 'package:global_market/helper/extension.dart';

class Product {
  String pName, pPrice, pDescription, pCategory, pImg, pId, brand;
  int pQuantity;
  Color color;

  Product({
    this.pQuantity,
    this.pName,
    this.pPrice,
    this.pDescription,
    this.pImg,
    this.pCategory,
    this.pId,
    this.brand,
    this.color,
  });
  // Product.fromJson(Map<dynamic, dynamic> map) {
  //   if (map == null) return;
  //   pQuantity = map['quantity'];
  //   pName = map['name'];
  //   pPrice = map['price'];
  //   pDescription = map['description'];
  //   pCategory = map['category'];
  //   pImg = map['image'];
  //   pId = map['productId'];
  //   brand = map['brand'];
  //   color = HexColor.fromHex(map['color']);
  // }
  // toJson() {
  //   return {
  //     'quantity': pQuantity,
  //     'name': pName,
  //     'price': pPrice,
  //     'description': pDescription,
  //     'image': pImg,
  //     'category=': pCategory,
  //     'productId': pId,
  //     'brand': brand,
  //     'color': color,
  //   };
  // }
}
